# Data Sources for the Holy Qur'an related to Elasticsearch

Basic approach


Arabic | Source Tanzil (regenerated from Bulkwalter coding from Corpus)
ArabicNoor |  This is generated field from regex patterns, source is Arabic field. Logic is defined under ar_original_noor subfield in mapping.json

## Details to add in this ReadMe (or other ReadMEs linked to this project)

### Associated projects
This section should mention the associated projects, their names and git urls. In future we can even work on making this a mono repo with each project as a git sub-module

### System Level architecture diagram
For the whole Elastic search system, api(s), injestion mechanisms, there should be a system level architecture diagram that defines
- Various high level components involved in the system
- Relationship of the components amongst each other

> We can use drawIO for diagrams

### Local Setup instructions
There should be complete instructions on how someone can locally setup Elastic Search and its associated components. Details could include
- System requirements
- List of softwares/tools to be installed.

### Merge request procedures
Merge procedures and branch structures should be defined. No code should be committed to master branch without a merge request

### Versioning and Changelog
Whenever code is merged to master (after a merge request). Project version number should be update and description should be added in a ChangeLog file on what has been added in this version

### Tag generation
After an external release, a tag has to be generated. If changeLog is properly maintained, all the information on what is part of this release would be in the chanageLog

### Use Case Diagrams
These projects should contain use case digrams for most common cases. The diagram could define the data flow for queries. for e.g
- English/Arabic word search
- English/Arabic phrase search
- Phonetic search

### Code Linting / Structuring Guidelines
Projects either should contain automatic linters of linting guidelines should be added. The design patterns that a project must follow should be mentioned

### Unit Testing / Integration Testing / Testing Coverage
Each project should contain a suite for adding unit and integration testing. A mechanism to find out how much code is covered in testing should be implemented

### Deployment Instructions
There should be clear instructions/scripts that define the process on how to deploy the project(s) to production and dev environments. Deployment windows have to be defined as well and process on how to notify associated parties should be mentioned.



