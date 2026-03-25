This archive contains the full-resolution images for our ER Model and Relational Diagram, as well as the SQL files for deploying and querying our database.

To set up the database for the first time, run the files in the following order:

1. _M-T9-Cineplex-CreateTables.sql_
2. _M-T9-Cineplex-InsertData.sql_

Any subsequent re-deployment of the database will require the following order of execution:

1. _M-T9-Cineplex-DropTables.sql_
2. _M-T9-Cineplex-CreateTables.sql_
3. _M-T9-Cineplex-ResetData.sql_
4. _M-T9-Cineplex-InsertData.sql_

Finally, use _M-T9-Cineplex-SampleQueries.sql_ to retrieve useful information from the database.

## Contributors:

1. [Jade](https://github.com/jusjade):

- Project Proposal
- SQL Table Creation
- Editing of Final Report
- Model Vulnerability Check
- Integrity Controls
- SQL Data Manipulation
- ER Data Model
- Structurized Final Report

2. [Minh](https://github.com/NhatMinhPhan):

- Project Proposal
- Contributed rough implementations of tables _ADMISSION_, _USER_, _SCENECARD_, _ORDER_. _PAYMENT_, _TICKET_, _CONCESSIONITEM_, _CONCESSIONORDER_
- SQL Data Entry
- SQL Data Manipulation by implementing SELECT and UPDATE queries, accounting for all kinds of manipulated data.
- Prepared a rough draft of the project final report
- Assisted in editing and finalizing the current iteration of the report

3. [Andrew](https://github.com/manseband):

- Project Proposal
- ER Data Model
- Integrity Controls
- SQL Table Creation
- SQL Data Entry
- SQL Data Manipulation
- Editing of final report
- Packaging of relevant files

4. [tfishhy](https://github.com/tfishhy):

- Project Proposal
- ER Data Model
- Integrity Controls
- Relational Diagram
- SQL Table Creation
- SQL Data Entry
- Contributed to the final report

5. [Jay](https://github.com/tisjayy):

- Project Proposal
- Functional Requirements
- Business Rules and Assumption
- ER Data Model
- Logical Design
- SQL Data Entry
- SQL Data Manipulation
- Limitations
- Editing of Final Report
