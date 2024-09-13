% Load the multi-species metabolic model from the SBML file
mmGEM = readCbModel('mmGEM.sbml');

% Define the prefix tags used to identify different species in the community
nameTags = {'SRB_'; 'MET_'; 'SOB_'};

% Retrieve species names and their corresponding IDs from the model based on name tags
[names, ids] = getMultiSpeciesModelId(mmGEM, nameTags);

% Store the species names in the model structure for later reference
mmGEM.infoCom = names;

% Store the species IDs in the model structure for further use in simulations
mmGEM.indCom = ids;

% Define the biomass reaction names for each species in the community
mmGEM.infoCom.spBm = {'SRB_biomass_ac_biosynthesis',    % Sulfate-Reducing Bacteria (SRB) biomass reaction
    'MET_biomass_ms_biosynthesis',                      % Methanogen (MET) biomass reaction
    'SOB_biomass_cl_biosynthesis'};                     % Sulfide-Oxidizing Bacteria (SOB) biomass reaction

% Find the corresponding reaction IDs for the biomass reactions and store them
mmGEM.indCom.spBm = findRxnIDs(mmGEM, mmGEM.infoCom.spBm);

% Run the SteadyCom algorithm to simulate the community's steady-state growth
[sol, result] = SteadyCom(mmGEM);