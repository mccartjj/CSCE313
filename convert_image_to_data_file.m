function image2 = convert_image_to_data_file (image_file)

image = imread(image_file);
image2 = zeros(240,320,3);
myfile=fopen('myfile.dat','wb');
n=0;
col_border = 160 - floor(size(image,2)/2);
row_border = 120 - floor(size(image,1)/2);

% top border
for i=1:row_border
    for j=1:320
        for k=1:size(image,3)
            image2(i,j,k)=0;
        end
        data=0;
        fwrite(myfile,data,'uint8');
        fwrite(myfile,data,'uint8');
        fwrite(myfile,data,'uint8');
        n=n+1;
    end
end

for i=row_border+1:row_border+size(image,1)    
    % left border
    for j=1:col_border
        for k=1:size(image,3)
            image2(i,j,k)=0;
        end
        data=0;
        fwrite(myfile,data,'uint8');
        fwrite(myfile,data,'uint8');
        fwrite(myfile,data,'uint8');
        n=n+1;
    end
    
    % image
    for j=col_border+1:col_border+size(image,2)
        for k=1:size(image,3)
            image2(i,j,k)=image(i-row_border,j-col_border,k);
        end
        %data=floor(double(image(i-row_border,j-col_border,1))/8)*2^11+floor(double(image(i-row_border,j-col_border,2))/4)*2^5+floor(double(image(i-row_border,j-col_border,3))/8);
        data = image(i-row_border,j-col_border,1);
        fwrite(myfile,data,'uint8');
        data = image(i-row_border,j-col_border,2);
        fwrite(myfile,data,'uint8');
        data = image(i-row_border,j-col_border,3);
        fwrite(myfile,data,'uint8');
        n=n+1;
    end
    
    % right border
    for j=col_border+size(image,2)+1:320
        for k=1:size(image,3)
            image2(i,j,k)=0;
        end
        data=0;
        fwrite(myfile,data,'uint8');
        fwrite(myfile,data,'uint8');
        fwrite(myfile,data,'uint8');
        n=n+1;
    end    
end

% bottom border
for i=row_border+size(image,1)+1:240
    for j=1:320
        for k=1:size(image,3)
            image2(i,j,k)=0;
        end
        data=0;
        fwrite(myfile,data,'uint8');
        fwrite(myfile,data,'uint8');
        fwrite(myfile,data,'uint8');
        n=n+1;
    end
end

fclose(myfile);

unix('zip -0 myfile.zip myfile.dat');

image2=uint8(image2);
imagesc(image);
title('original image');
figure;
imagesc(image2);
title('bordered image');