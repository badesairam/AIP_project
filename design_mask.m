function h = design_mask()
    w = complex(cos(2*pi/32),sin(2*pi/32));
    F = zeros(32,32);
    for i=1:32
        for j=1:32
            F(i,j) = w^((i-1)*(j-1));
        end
    end
    Fi = inv(F);
    Gs = zeros(32,32,32);
    A_list = randn(32*32)*1/16;
    for i=1:32 
        Gs(:,:,i) =F * circulant(A_list((i-1)*32+1:i*32)') * Fi;
    end
    Cs = zeros(32,32,32);
    for j=1:32
        Cs(:,:,j) = Gs(:,:,1) + ((-1)^(j-1))*Gs(:,:,17);
        for t=2:16
            Cs(:,:,j) = Cs(:,:,j) + real(Gs(:,:,t)*(w^((1-t)*(j-1))));
        end
    end
    
    H = zeros(32*32,1);
    
    for k=1:32
        H((k-1)*32+1:k*32) = diag(Cs(:,:,k));
    end
    h = ifft(H);
end