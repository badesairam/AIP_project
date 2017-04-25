function B4frames = scriptB4(maskedframes,R1,R2,W,niter)
    sz = 120*120;
    W4 = zeros(4*sz,4*sz);
    for j=1:4
        W4((j-1)*sz+1:j*sz,(j-1)*sz+1:j*sz) = W;
        W4((j-1)*sz+1:j*sz,1:sz) = W;
    end
    intialize = zeros(4*sz,1);
    B4frames = zeros(120,120,20);
    for i = 1:17
        y = [reshape(maskedframes(:,:,i),900,1); reshape(maskedframes(:,:,i+1),900,1);reshape(maskedframes(:,:,i+2),900,1);reshape(maskedframes(:,:,i+3),900,1)];
        RR = zeros(4*sz,4*sz);
        if rem(i,2)==0 
            RR(1:sz,1:sz) = R2;
            RR(sz+1:2*sz,sz+1:2*sz) = R1;
            RR(2*sz+1:3*sz,2*sz+1:3*sz) = R2;
            RR(3*sz+1:4*sz,3*sz+1:4*sz) = R1;
            x = GPSR_Basic(y,RR*W4,0.1,'MaxiterA',niter,'Initialization',intialize,'Verbose',0);
        elseif rem(i,2)==1
            RR(1:sz,1:sz) = R1;
            RR(sz+1:2*sz,sz+1:2*sz) = R2;
            RR(2*sz+1:3*sz,2*sz+1:3*sz) = R1;
            RR(3*sz+1:4*sz,3*sz+1:4*sz) = R2;
            x = GPSR_Basic(y,RR*W4,0.1,'MaxiterA',niter,'Initialization',intialize,'Verbose',0);
        end
        dtheta = zeros(sz,1);
        intialize = [x(1:sz)+x(sz+1:2*sz);dtheta;dtheta;dtheta];
        B4frames(:,:,i) = reshape(W*x(1:sz),120,120);
    end
    B4frames(:,:,18) = reshape(W*(x(1:sz)+x(sz:2*sz)),120,120);
    B4frames(:,:,19) = reshape(W*(x(1:sz)+x(2*sz:3*sz)),120,120);
    B4frames(:,:,20) = reshape(W*(x(1:sz)+x(3*sz:4*sz)),120,120);
end
        
            