function [field,intense] = TFFT(res_x,res_y,lambda,L0,L1,distance,input_filed_intense)
    % TFFT_cpu: 在 cPU 上计算傅里叶衍射
    k = single(2 * pi / lambda);
    i = 1i;  % 虚数单位
    tem_x0 = single(linspace(-L0 / 2, L0 / 2, res_x));
    tem_y0 = single(linspace(-L0 / 2, L0 / 2, res_y));   
    % 在 GPU 上生成衍射面
    [tem_x0, tem_y0] = meshgrid(tem_x0, tem_y0);    
    % 定义常数项和相位因子
    tem_F0 = single(exp(i * k * distance) / (i * lambda * distance));
    tem_F = exp(i * k / (2* distance) * (tem_x0 .^ 2 + tem_y0 .^ 2));  
    F0FFT = fft2(input_filed_intense);
    FFFT = fft2(tem_F);
    FFTU = F0FFT .* FFFT;   
    % 计算场和强度
     field = tem_F0 .* fftshift(ifft2(FFTU));  
    %%改为场的计算
    field = field ./ max(max(abs(field)));
    intense = abs(field).^2;

end
