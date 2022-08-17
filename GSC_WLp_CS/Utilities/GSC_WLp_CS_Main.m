
%--------------------------------------------------------------------------
function [filename,subrate, PSN_Result,FSIM_Result,SSIM_Final]=GSC_WLp_CS_Main(filename,IterNum,subrate,mu,patches,p)


        Original_Filename = [filename '.tif'];
        
        Original_Image = imread(Original_Filename);
        
        [Row, Col,kkk] = size(Original_Image);
        
        
        if kkk==3
            Original_Image=double(rgb2gray(Original_Image));
        else
           Original_Image=double((Original_Image));
        end
        
        % Constructe Measurement Matrix (Gaussian Random)
        patch_size = 32;
        
        NN = patch_size * patch_size;
        
        MM = round(subrate * NN);
        
        randn('seed',0);
        
        PHI = orth(randn(NN, NN))';
        
        PHI = PHI(1:MM, :);
        
        X = im2col(Original_Image, [patch_size patch_size], 'distinct');
        
        Y = PHI * X;  % CS Measurements
        
        fprintf('。。。。。。。。。。。。。。。\n');
        fprintf(filename);
        fprintf('\n');
        fprintf('。。。。。。。。。。。。。。。\n');
        fprintf('rate = %0.2f\n',subrate);
        fprintf('。。。。。。。。。。。。。。。\n');
        
        disp('Using BCS Initilization ...');
        
        [x_MH, ~] = MH_BCS_SPL_Decoder(Y, PHI, subrate, Row, Col);
        
        disp('Ending BCS Initilization ...');

        par = [];
        
        if ~isfield(par,'PHI')
             par.PHI = PHI;
        end
        if ~isfield(par,'patch_size')        
             par.patch_size = patch_size;
        end
       if ~isfield(par,'Row')    
             par.Row = Row;
       end
       if ~isfield(par,'Col')           
        par.Col = Col;
       end
   
       if ~isfield(par,'patch')
            par.patch = patches;
       end  
       
       if ~isfield(par,'mu')
            par.mu = mu;
       end
       
       if ~isfield(par,'sigma')
            par.sigma = sqrt(2);
       end
       
      if ~isfield(par,'e')
            par.e = 0.4;
       end
        
        if ~isfield(par,'Initial')
            par.Initial = double(x_MH);
        end
        if ~isfield(par,'Org')        
        par.Org = Original_Image;
        end
        
        if ~isfield(par,'IterNum')
            par.IterNum = IterNum;
        end

        if ~isfield(par,'loop')
            par.loop = 200;
        end
        
        if ~isfield(par,'step')
            par.step = 4;
        end  
         
         if ~isfield(par,'Similar_patch')
             par.Similar_patch = 60; % 60 or 40
         end
         
         if ~isfield(par,'Region')
              par.Region = 20;
         end    
         
    %    fprintf('Initial PSNR = %0.2f\n',csnr(par.Org,par.Initial,0,1));


        [reconstructed_image, PSN_Result,FSIM_Result,SSIM_Final]= CS_GSC_WLp(Y, par,p);


        if subrate==0.2
            
        Final_Name= strcat(filename,'_GSC_WLp_CS_',num2str(subrate),'_PSNR_',num2str(PSN_Result),'_FSIM_',num2str(FSIM_Result),'_SSIM_',num2str(SSIM_Final),'.png');
            
        imwrite(uint8(reconstructed_image),strcat('./ratio_0.2_Results/',Final_Name));

        
        elseif subrate==0.3
            
        Final_Name= strcat(filename,'_GSC_WLp_CS_',num2str(subrate),'_PSNR_',num2str(PSN_Result),'_FSIM_',num2str(FSIM_Result),'_SSIM_',num2str(SSIM_Final),'.png');
        
        imwrite(uint8(reconstructed_image),strcat('./ratio_0.3_Results/',Final_Name));
        
        elseif subrate==0.4
            
        Final_Name= strcat(filename,'_GSC_WLp_CS_',num2str(subrate),'_PSNR_',num2str(PSN_Result),'_FSIM_',num2str(FSIM_Result),'_SSIM_',num2str(SSIM_Final),'.png');
        
        imwrite(uint8(reconstructed_image),strcat('./ratio_0.4_Results/',Final_Name));
        else
            
        Final_Name= strcat(filename,'_GSC_WLp_CS_',num2str(subrate),'_PSNR_',num2str(PSN_Result),'_FSIM_',num2str(FSIM_Result),'_SSIM_',num2str(SSIM_Final),'.png');
            
        imwrite(uint8(reconstructed_image),strcat('./ratio_0.5_Results/',Final_Name));
                     
       end    



end

