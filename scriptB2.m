function B2frames = scriptB2(maskedframes,R1,R2,W,niter)
    sz = 120*120;
    W2 = zeros(2*sz,2*sz);
    W2(1:sz,1:sz) = W;
    W2(sz+1:2*sz,sz+1:2*sz) = W;
    W2(sz+1:2*sz,1:sz) = W;
    intialize = zeros(2*sz,1);
    B2frames = zeros(120,120,20);
    for i = 1:19
        y = [reshape(maskedframes(:,:,i),900,1); reshape(maskedframes(:,:,i+1),900,1)];
        RR = zeros(2*sz,2*sz);
        if rem(i,2)==0 
            RR(1:sz,1:sz) = R2;
            RR(sz+1:2*sz,sz+1:2*sz) = R1;
            x = GPSR_Basic(y,RR*W2,0.1,'MaxiterA',niter,'Initialization',intialize,'Verbose',0);
        elseif rem(i,2)==1
            RR(1:sz,1:sz) = R1;
            RR(sz+1:2*sz,sz+1:2*sz) = R2;
            x = GPSR_Basic(y,RR*W2,0.1,'MaxiterA',niter,'Initialization',intialize,'Verbose',0);
        end
        dtheta = zeros(sz,1);
        intialize = [x(1:sz)+x(sz+1:2*sz);dtheta];
        B2frames(:,:,i) = reshape(W*x(1:sz),120,120);
    end
    B2frames(:,:,20) = reshape(W*(x(1:sz)+x(sz+1:2*sz)),120,120);
end
        
            