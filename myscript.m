if ~exist('job_id')
    job_id = 0000;
end


nrow = 20;
ncol = 10;

m = randn(nrow, ncol);                      % random 10x10 matrix

outfile = ['./data/test_', num2str(job_id), '.csv'];
fid = fopen(outfile, 'w');           % get file handle of output file
for row = 1:nrow
    fprintf(fid, '%f\t', m(row,:));     % write tab-deliminated row
    fprintf(fid, '\n');
end

fclose(fid);

