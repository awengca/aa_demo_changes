% Download dataset from the URL into an aa_demo folder as specified in
% aap.directory_conventions.rawdatadir. It also adds data to
% aap.directory_conventions.rawdatadir;
% If no URL is provided then the small aa_demo from Rhodri Cusack will be used.
%
% ds114_test : https://files.osf.io/v1/resources/9q7dv/providers/osfstorage/57e549f9b83f6901d457d162
%
% aap = aa_downloaddemo(aap,[URL, [rawdir]])
function aap = aa_downloaddemo(aap,URL,rawdir)


DATA = {...
    'https://files.osf.io/v1/resources/umhtq/providers/osfstorage/5b7465680b87a00018c6a76f', 'aa_demo';...
    };

if nargin < 2
    URL = DATA{1,1};
    rawdir = DATA{1,2};
end

    demodir = string(aap.directory_conventions.rawdatadir);
    
    % attempt to download the data
    aas_log(aap, false, 'INFO: Downloading...')
    outfn = [tempname '.tar.gz'];
    assert(aas_shell(sprintf('wget -O %s %s',outfn,URL))==0, ...
        'could not download dataset');
    [s, w] = aas_shell(sprintf('tar -xvf %s -C %s',outfn,demodir));
    assert(s==0);
    
    % the sub-directory should now exist
    newdir = fullfile(demodir,rawdir);
    aas_log(aap, false, 'INFO: Download complete');
    assert( 7 == exist(newdir), ...
         'INFO: data set not successfuly downloaded');
    aas_log(aap, false, 'INFO: done');
    
    % delete the downloaded archive
    delete(outfn);
    % add dataset to rawdatadir
    disp(demodir)
    aap.directory_conventions.rawdatadir = demodir;
end