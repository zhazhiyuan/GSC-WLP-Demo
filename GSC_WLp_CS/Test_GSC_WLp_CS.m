clc
clear
m_20=0; 
m_30=0;    
m_40=0;  
m_10=0;  

All_data_Results_20 = cell(1,200);
All_data_Results_30 = cell(1,200);
All_data_Results_40 = cell(1,200);
All_data_Results_10 = cell(1,200);

for i =1:8
    
ImgNo =i;

switch ImgNo
    
            case 1
                filename = 'Barbara';
            case 2
                filename = 'bridge';
            case 3
                filename = 'elaine';
            case 4
                filename = 'Fence';    
            case 5
                filename = 'House'; 
                
            case 6
                filename = 'lena';
            case 7
                filename = 'peppers';
            case 8
                filename = 'straw';
                
end


for m  =   1:4

rate     =    [0.2, 0.3, 0.4, 0.5];

Subrate =  rate(m);

if Subrate==0.2
    
mu  =0.0005; p =0.5;

elseif Subrate==0.3
    
mu  =0.05; p =0.95;

elseif Subrate==0.4
    
mu  =0.05; p =0.95;
    
else
    
mu  =0.05; p =0.95;

end


patches=7;


IterNum   =   600;


if  Subrate==0.2
    
    
 [Ori, Subrate, PSNR_Final,  FSIM_Final,  SSIM_Final] =   GSC_WLp_CS_Main (filename,  IterNum,  Subrate,  mu,  patches,   p);
 
 m_10= m_10+1;
 
 s=strcat('A',num2str(m_10));
 
 All_data_Results_10{m_10}={Ori, Subrate, PSNR_Final,FSIM_Final,SSIM_Final};
 
 xlswrite('GSC_WLp_CS_0.2.xls', All_data_Results_10{m_10},'sheet1',s);
 
elseif  Subrate==0.3
    
 [Ori, Subrate, PSNR_Final,  FSIM_Final,  SSIM_Final] =   GSC_WLp_CS_Main(filename,  IterNum,  Subrate,  mu,  patches,   p);
 
 m_20= m_20+1;
 
 s=strcat('A',num2str(m_20));
 
 All_data_Results_20{m_20}={Ori, Subrate, PSNR_Final,FSIM_Final,SSIM_Final};
 
 xlswrite('GSC_WLp_CS_0.3.xls', All_data_Results_20{m_20},'sheet1',s);
 
 elseif  Subrate==0.4
     
 [Ori, Subrate, PSNR_Final,  FSIM_Final,  SSIM_Final] =   GSC_WLp_CS_Main(filename,  IterNum,  Subrate,  mu,  patches,   p);
 
 m_30= m_30+1;
 
 s=strcat('A',num2str(m_30));
 
 All_data_Results_30{m_30}={Ori, Subrate, PSNR_Final,FSIM_Final,SSIM_Final};
 
 xlswrite('GSC_WLp_CS_0.4.xls', All_data_Results_30{m_30},'sheet1',s);
 
else
    
 [Ori, Subrate, PSNR_Final,  FSIM_Final,  SSIM_Final] =   GSC_WLp_CS_Main(filename,  IterNum,  Subrate,  mu,  patches,   p);
 
 m_40= m_40+1;
 
 s=strcat('A',num2str(m_40));
 
 All_data_Results_40{m_40}={Ori, Subrate, PSNR_Final,FSIM_Final,SSIM_Final};
 
 xlswrite('GSC_WLp_CS_0.5.xls', All_data_Results_40{m_40},'sheet1',s);
 
end


clearvars -except filename i m_20 All_data_Results_20 m_30 All_data_Results_30 m_40 All_data_Results_40 m_10 All_data_Results_10
end
clearvars -except filename  m_20 All_data_Results_20 m_30 All_data_Results_30 m_40 All_data_Results_40 m_10 All_data_Results_10
end





         