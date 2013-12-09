function [RSK,dbid] = RSKopen(fname)
% assumes only a single instrument deployment in RSK

% modified 21/March/2013
%   added error message if file does not exist

if ~exist(fname,'file')
    disp('File cannot be found')
    RSK=[];dbid=[];
    return
end
dbid = mksqlite('open',fname);

RSK.dbInfo = mksqlite('select version from dbInfo');

RSK.datasets = mksqlite('select * from datasets');
RSK.datasetDeployments = mksqlite('select * from datasetDeployments');

RSK.instruments = mksqlite('select * from instruments');
RSK.instrumentChannels = mksqlite('select * from instrumentChannels');
RSK.instrumentSensors = mksqlite('select * from instrumentSensors');

RSK.channels = mksqlite('select longName,units from channels');

RSK.epochs = mksqlite('select deploymentID,startTime/1.0 as startTime, endTime/1.0 as endTime from epochs');
RSK.epochs.startTime = RSKtime2datenum(RSK.epochs.startTime);
RSK.epochs.endTime = RSKtime2datenum(RSK.epochs.endTime);

RSK.schedules = mksqlite('select * from schedules');


RSK.appSettings = mksqlite('select * from appSettings');
RSK.deployments = mksqlite('select * from deployments');

RSK.thumbnailData = RSKreadthumbnail;
