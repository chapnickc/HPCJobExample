m = randn(20, 10);                      % random 10x10 matrix

fid = fopen('test.csv', 'w');           % get file handle of output file

[nrow, ncol] = size(m);
for row = 1:nrow
    fprintf(fid, '%f\t', m(row,:));     % write tab-deliminated row
    fprintf(fid, '\n');
end

fclose(fid);

