
function [filename, p_miss, PSNR_Result,FSIM_Result, SSIM_Final]=GSC_WLp_Inpaint_Main(filename,IterNum,p_miss,mu,patch,p)

        Orgname = [filename '.tif'];
        
        X_RGB = imread(Orgname); 
        
        X_YUV = rgb2ycbcr(X_RGB);
        
        X = double(X_YUV(:,:,1)); 
        
        X_org = X;
        
        X_Inpaint_Re = zeros(size(X_YUV));
        
        X_Inpaint_Re(:,:,2) = X_YUV(:,:,2); 
        
        X_Inpaint_Re(:,:,3) = X_YUV(:,:,3); 
        
        ratio = p_miss; 


        rand('seed',0);
        
       O = double(rand(size(X)) > (1-ratio));

        
        Y= X.* O;  % Observed Image
       
        par = [];
        
        if ~isfield(par,'mu')
            par.mu = mu;
        end
        
        if ~isfield(par,'org')
            par.org = X_org;
        end  
        
        if ~isfield(par,'IterNums')
            par.IterNums = IterNum;
        end 
        
        if ~isfield(par,'Initial')
            par.Initial = Inter_Initial(Y,~O);
        end
        
        if ~isfield(par,'patch')
            par.patch = patch;
        end
        
         if ~isfield(par,'step')
            par.step = 4;
         end       
        
         if ~isfield(par,'Similar_patch')
             par.Similar_patch = 60; % 60 or 40
         end
         
         if ~isfield(par,'Region')
              par.Region = 25;
         end        
        
        if ~isfield(par,'sigma')
               par.sigma = sqrt(2);
        end 
        if ~isfield(par,'e')
               par.e = 0.3;
        end         
        
   
        
     fprintf('.........................................\n');
     fprintf(Orgname);
     fprintf('\n');
     fprintf('..........................................\n');
     

     fprintf('..............missing pixels.....   ratio = %f\n',ratio);

     fprintf('..................................................\n');

        [reconstructed_image, PSNR_Result,FSIM_Result,SSIM_Final] = Inpainting_GSC_WLp(Y,O,par,p);
        
        X_Inpaint_Re(:,:,1) = uint8(reconstructed_image);
        
        X_Inpainting_Re = ycbcr2rgb(uint8(X_Inpaint_Re));

       if ratio==0.2

        Final_Name= strcat(filename,'_GSC_WLp_','_miss_',num2str(1-ratio),'_PSNR_',num2str(PSNR_Result),'_FSIM_',num2str(FSIM_Result),'.png');
        
        imwrite(uint8(X_Inpainting_Re),strcat('./80_Missing_Results/',Final_Name));
        
        
        

        elseif ratio==0.3
            
        Final_Name= strcat(filename,'_GSC_WLp_','_miss_',num2str(1-ratio),'_PSNR_',num2str(PSNR_Result),'_FSIM_',num2str(FSIM_Result),'.png');
        
        imwrite(uint8(X_Inpainting_Re),strcat('./70_Missing_Results/',Final_Name));
        
        

        elseif ratio==0.4
            
        Final_Name= strcat(filename,'_GSC_WLp_','_miss_',num2str(1-ratio),'_PSNR_',num2str(PSNR_Result),'_FSIM_',num2str(FSIM_Result),'.png');
            
        imwrite(uint8(X_Inpainting_Re),strcat('./60_Missing_Results/',Final_Name));
        

       else
            
        Final_Name= strcat(filename,'_GSC_WLp_','_miss_',num2str(1-ratio),'_PSNR_',num2str(PSNR_Result),'_FSIM_',num2str(FSIM_Result),'.png');
            
        imwrite(uint8(X_Inpainting_Re),strcat('./50_Missing_Results/',Final_Name));
       
                                
        end    



end

