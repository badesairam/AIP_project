function maskedframes = masked(frames,A1,A2,sz)
    maskedframes = zeros(30,30,20);
    for i=1:20
        img = frames(:,:,i);
        img = reshape(img,sz,1);
        if rem(i,2)==0 
            img = A2*img;
        elseif rem(i,2)==1
            img = A1*img;
        end
        img = reshape(img,120,120);
        img = downsample(img,4);
        img = downsample(img',4);
        img = img + randn(30);
        maskedframes(:,:,i) = img';
    end
end