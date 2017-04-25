function Aframes = scriptA(maskedframes,R1,R2,W,niter)
    intialize = zeros(120*120,1);
    Aframes = zeros(120,120,20);
    for i = 1:20
        disp(i)
        if rem(i,2)==0 
            x = GPSR_Basic(reshape(maskedframes(:,:,i),900,1),R2*W,0.1,'MaxiterA',niter,'Initialization',intialize,'Verbose',0);
        elseif rem(i,2)==1
            x = GPSR_Basic(reshape(maskedframes(:,:,i),900,1),R1*W,0.1,'MaxiterA',niter,'Initialization',intialize,'Verbose',0);
        end
        intialize = x;
        Aframes(:,:,i) = reshape(W*x,120,120);
    end
end
        
            