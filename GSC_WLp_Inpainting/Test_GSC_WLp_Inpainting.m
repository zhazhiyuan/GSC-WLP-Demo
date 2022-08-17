clc
clear
m_20=0; 
m_30=0;    
m_40=0;  
m_10=0;  
m_50=0; 

All_data_Results_10 = cell(1,200);
All_data_Results_20 = cell(1,200);
All_data_Results_30 = cell(1,200);
All_data_Results_40 = cell(1,200);

for i =1:8
ImageNum =i;

switch ImageNum
              case 1
                filename = 'Butterfly';
             case 2
                filename = 'Fence';
             case 3
                filename = 'fireman';
             case 4
                filename = 'Golem';
             case 5
                filename = 'Mickey';
             case 6
                filename = 'Nanna';
             case 7
                filename = 'Starfish';
             case 8
                filename = 'Zebra';
 
end
for m  =   1:4
    

miss_rate     =    [0.2,0.3,0.4,0.5];


p_miss =  miss_rate(m);


if p_miss==0.2
    
     mu     =   0.0003;  p=0.45;
    
elseif p_miss==0.3
    
     mu     =   0.0003;  p=0.45;
    
elseif p_miss==0.4
    
      mu     =   0.03;   p=0.95;   
    
else
    
     mu     =   0.04;    p=0.95;   
    
end

patches=8;

IterNum   =   800;





%80% missing

 if  p_miss==0.2
     
 [Ori,  p_miss,  PSNR_Final,FSIM_Final,SSIM_Final]= GSC_WLp_Inpaint_Main(filename,IterNum,p_miss,mu,patches,p);
 
 m_10= m_10+1;
 
 s=strcat('A',num2str(m_10));
 
 All_data_Results_10{m_10}={Ori, p_miss,  PSNR_Final,FSIM_Final,SSIM_Final};
 
 xlswrite('WLp_Inpaint_0.2.xls', All_data_Results_10{m_10},'sheet1',s);
 
 
%70% missing

 elseif  p_miss==0.3
     
 [Ori, p_miss,  PSNR_Final,FSIM_Final,SSIM_Final]=GSC_WLp_Inpaint_Main(filename,IterNum,p_miss,mu,patches,p);
 
 m_20= m_20+1;
 
 s=strcat('A',num2str(m_20));
 
 All_data_Results_20{m_20}={Ori, p_miss,  PSNR_Final,FSIM_Final,SSIM_Final};
 
 xlswrite('WLp_Inpaint_0.3.xls', All_data_Results_20{m_20},'sheet1',s);
 
 
 %60% missing

 
  elseif  p_miss==0.4
     
 [Ori, p_miss,  PSNR_Final,FSIM_Final,SSIM_Final]=GSC_WLp_Inpaint_Main(filename,IterNum,p_miss,mu,patches,p);
 
 m_30= m_30+1;
 
 s=strcat('A',num2str(m_30));
 
 All_data_Results_30{m_30}={Ori, p_miss,  PSNR_Final,FSIM_Final,SSIM_Final};
 
 xlswrite('WLp_Inpaint_0.4.xls', All_data_Results_30{m_30},'sheet1',s);
 
 %50% missing

 else
     
 [Ori, p_miss,  PSNR_Final,FSIM_Final,SSIM_Final]=GSC_WLp_Inpaint_Main(filename,IterNum,p_miss,mu,patches,p);
 
 m_40= m_40+1;
 
 s=strcat('A',num2str(m_40));
 
 All_data_Results_40{m_40}={Ori, p_miss,  PSNR_Final,FSIM_Final,SSIM_Final};
 
 xlswrite('WLp_Inpaint_0.5.xls', All_data_Results_40{m_40},'sheet1',s);
 
 end



clearvars -except filename i m_20 All_data_Results_20 m_30 All_data_Results_30 m_40 All_data_Results_40 m_10 All_data_Results_10 
end
clearvars -except filename  m_20 All_data_Results_20 m_30 All_data_Results_30 m_40 All_data_Results_40 m_10 All_data_Results_10
end





         