# Mentor–Mentee Academic Monitoring System

A DBMS project built using MySQL to manage mentor-mentee 
relationships, track academic progress, and record interventions.

## 📌 Problem Statement
Educational institutions lack a centralized system to track 
mentoring. This system solves that using a relational database.

## 🗂️ Database Schema
8 tables: `mentor`, `mentee`, `mentorship_assignment`, `meeting`,
`progress_report`, `goal`, `action_item`, `intervention`

## 🔗 Relationships
- Mentor → Mentorship Assignment (1:M)
- Mentee → Mentorship Assignment (1:M)
- Assignment → Meeting (1:M)
- Meeting → Action Item (1:M)
- Mentee → Goal (1:M)
- Mentee → Progress Report (1:M)
- Mentee → Intervention (1:M)

## 📊 ER Diagram
![ER Diagram](diagrams/er_diagram.png)

## 🚀 How to Run
 
### Option 1 — Inside MySQL (interactive)
```sql
source sql/schema.sql
source sql/insert_data.sql
source sql/queries.sql
```
 
### Option 2 — Using the Command Line (CLI)
 
**Step 1: Clone the repository**
```bash
git clone https://github.com/your-username/mentor-mentee-dbms.git
cd mentor-mentee-dbms
```
 
**Step 2: Log into MySQL**
```bash
mysql -u root -p
```
 
**Step 3: Run the files one by one**
```bash
mysql -u root -p < sql/schema.sql
mysql -u root -p < sql/insert_data.sql
mysql -u root -p < sql/queries.sql
```
 
**Or run all 3 in one command:**
```bash
mysql -u root -p mmams < sql/schema.sql && \
mysql -u root -p mmams < sql/insert_data.sql && \
mysql -u root -p mmams < sql/queries.sql
```

> ⚠️ Run `schema.sql` first — it creates the database and tables.
> `insert_data.sql` and `queries.sql` depend on it.

## 🛠️ Tools Used
- MySQL
- Draw.io (ER Diagrams)

**Contributors**
  - Akashh [@Aka-bot2](https://github.com/Aka-bot2)
  - Chetan [@Chetan-37](https://github.com/Chetan-37)
