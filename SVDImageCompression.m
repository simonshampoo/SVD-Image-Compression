% read image
A = imread('gauss.jpg');

%initial processing, since B/W pic, we only need to use A(:,:,1) since the
%three values A(i,j,1:3) are used as RGB values to color pixel in i-th row and j-th column
B = double(A(:,:,1)); 

%scale values of B to range (0,1)
B = B/255;

% using single value decomposition of B
[U, S, V] = svd(B);
%size(U), size(S), size(V) = 445x445, 445x672, 672x672, respectively,
%dimensions of picture is size(S), 445 px x 672 px

% define k = 1 for rank 1
k = 1; 

%find closest rank 1 approximation to B, w.r.t Frobenius norm
rank1 = U(:,1:k)*S(1:k,1:k)*V(:,1:k)'; 

%visualizing the rank
%copy rank1 to new matrix C
C = zeros(size(A)); C(:,:,1) = rank1; C(:,:,2) = rank1; C(:,:,3) = rank1; 

%exception check because lower-rank approximation can have values slightly
%below 0 and slightly above 1
C = max(0, min(1,C)); 

%display image
image(C), axis image
image()
%--------------------------------------------------------------------------------
%higher rank matrix, rank = 10, same steps as above
k = 10;
rank2 = U(:,1:k)*S(1:k,1:k)*V(:,1:k)';

C1 = zeros(size(A)); C1(:,:,1) = rank2; C1(:,:,2) = rank2; C1(:,:,3) = rank2; 

C1 = max(0, min(1,C1)); 
%--------------------------------------------------------------------------------
%even higher rank matrix, rank = 40, same steps as above
k = 40;
rank3 = U(:,1:k)*S(1:k,1:k)*V(:,1:k)';

C2 = zeros(size(A)); C2(:,:,1) = rank3; C2(:,:,2) = rank3; C2(:,:,3) = rank3; 

C2 = max(0, min(1,C2)); 
%--------------------------------------------------------------------------------
%max rank, same steps as above
k = 445;
rank4 = U(:,1:k)*S(1:k,1:k)*V(:,1:k)';

C3= zeros(size(A)); C3(:,:,1) = rank4; C3(:,:,2) = rank4; C3(:,:,3) = rank4; 

C3 = max(0, min(1,C3)); 

%display all pictures, rank 1, rank 10, rank 40, respectively
Im = [C, C1;C2, C3];
image(Im)
% Compression rate is k(m+n+1)/(mn), where k is the rank
% Ex: used rank 40, so 40(445+672+1)/(445*672) = .1495 = 14.95%
% compression rate, 14.95% of data of original image was used

