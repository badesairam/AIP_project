addpath('mmread/');
addpath('GPSR/');
A = mmread('cars.avi');
frames = zeros(120,120,20);
tic;
for i=1:20 
    B = rgb2gray(A.frames(:,i).cdata);
    frames(:,:,i) = B(81:200,151:270);
end

%bicubic interpolation 
img1 = frames(:,:,1);
img1 = downsample(img1,4);
img1 = downsample(img1',4);
img1 = img1';
imginterpolated = imresize(img1,4);

%our method
%A1 and A2 are created and saved and to be loaded as A1,A2
%create A's and create the masked images  
sz = 120*120;

% A1_list = randn(sz)*1/4;
% A2_list = randn(sz)*1/4;
% circs1 = zeros(120,120,120);
% circs2 = zeros(120,120,120);
% for i=1:120
%     circs1(:,:,i) = circulant(A1_list((i-1)*120+1:i*120)');
%     circs2(:,:,i) = circulant(A2_list((i-1)*120+1:i*120)');
% end
% 
% c = repmat(0:119,120,1);
% c = mod(c+c',120);
% c = c+1;
% 

A1 = zeros(sz,sz);
A2 = zeros(sz,sz);

%pseudo circulant matrices from the masks paper
% for i=1:120
%     for j=1:120
%         A1((i-1)*120+1:i*120,(j-1)*120+1:j*120) = circs1(:,:,c(i,j));
%         A2((i-1)*120+1:i*120,(j-1)*120+1:j*120) = circs2(:,:,c(i,j));
%     end
% end
% save('A1.mat','A1');
% save('A2.mat','A2');
% W = haarmtx(sz);
% save('W.mat','W');


AA1 = load('A1.mat');
AA2 = load('A2.mat');
WW = load('W.mat');
A1 = AA1.A1;
A2 = AA2.A2;
W = WW.W;

disp('A1 and A2 and W loaded');


%applying masks to the frames
maskedframes = masked(frames,A1,A2,sz);
% 
% imshow(mat2gray(maskedframes(:,:,i)));

%downsampling matrix
D = zeros(900,120*120);
ind = 1;
rows_ind = 1;
for i=1:900
    D(i,120*4*(rows_ind-1)+ind) = 1;
    ind = ind + 4;
    if mod(i,30)==0
        rows_ind = rows_ind + 1;
        ind = 1;
    end
end

R1 = D*A1;
R2 = D*A2;
toc;






