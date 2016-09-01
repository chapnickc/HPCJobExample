nrow = 20;
ncol = 10;

m = randn(nrow, ncol);                      % random 10x10 matrix

fid = fopen('test.csv', 'w');           % get file handle of output file
for row = 1:nrow
    fprintf(fid, '%f\t', m(row,:));     % write tab-deliminated row
    fprintf(fid, '\n');
end

fclose(fid);

