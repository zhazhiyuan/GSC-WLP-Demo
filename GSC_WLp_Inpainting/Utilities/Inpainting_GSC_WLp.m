

function [reconstructed_image, PSN_Result,FSIM_Result, SSIM_Result] = Inpainting_GSC_WLp(Y,A,par,p)

Initial = par.Initial;

mu = par.mu;

IterNums = par.IterNums;

X_Org = par.org;

MASK = A;

A = @(x) MASK.*x;

AT = @(x) MASK.*x;

ATy = AT(Y);

X = Initial;

C = zeros(size(Y));

L = zeros(size(Y));

Muinv = 1/mu;

InvAAT = 1./(mu+MASK);

All_PSNR= zeros(1,IterNums);

fprintf('Initial PSNR = %f\n',csnr(X,X_Org,0,1));

for j = 1:IterNums
    
    L = GSC_WLp_GST(X-C, par,p); %Eq.36
    
    R = ATy +mu*(L+C); 
    
    X = Muinv*(R - AT(InvAAT.*A(R))); % Eq.28
    
    C = C + (L - X);    % Eq.26
    
    All_PSNR(j) = csnr(X,X_Org,0,0);
    
    fprintf('iter number = %d, PSNR = %f, SSIM = %f\n',j,csnr(X,X_Org,0,0),cal_ssim(X_Org,X,0,0));

    if j>1
        if(All_PSNR(j)-All_PSNR(j-1)<0)
            break;
        end
    end

end

reconstructed_image = X;

PSN_Result  = csnr(reconstructed_image,X_Org,0,0);
FSIM_Result = FeatureSIM(reconstructed_image,X_Org);
SSIM_Result = cal_ssim(reconstructed_image,X_Org,0,0);


end

