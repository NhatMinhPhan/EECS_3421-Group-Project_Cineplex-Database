This archive contains the full-resolution images for our ER Model and Relational Diagram, as well as the SQL files for deploying and querying our database.

To set up the database for the first time, run the files in the following order:
1. M-T9-Cineplex-CreateTables.sql
2. M-T9-Cineplex-InsertData.sql

Any subsequent re-deployment of the database will require the following order of execution:
1. M-T9-Cineplex-DropTables.sql
2. M-T9-Cineplex-CreateTables.sql
3. M-T9-Cineplex-ResetData.sql
4. M-T9-Cineplex-InsertData.sql

Finally, use M-T9-Cineplex-SampleQueries.sql to retrieve useful information from the database.
