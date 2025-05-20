# MS SQL Server Index Maintenance Scripts

This repository contains SQL scripts designed to improve performance on Microsoft SQL Server by maintaining indexes through rebuilding or reorganizing them based on their fragmentation levels.

## 📋 Overview

Over time, indexes can become fragmented, which leads to slower query performance. These scripts:

- Identify fragmented indexes
- Rebuild indexes with heavy fragmentation (>30%)
- Optionally reorganize indexes with moderate fragmentation (5–30%)
- Are compatible with SQL Server 2012 and newer


## 🧪 Usage

1. Open SQL Server Management Studio (SSMS)
2. Connect to your target database
3. Replace `YourDatabase` in the script with your actual DB name
4. Execute the script manually **outside of business hours**, or
5. Schedule via a SQL Agent job for regular maintenance

## 🧰 Requirements

- SQL Server 2012 or newer
- Appropriate permissions to run `ALTER INDEX` on the target tables

## 📅 Recommendation

We recommend running the script weekly or during off-peak hours to ensure optimal query performance and minimal downtime.

## 📜 License

This repository is released under the MIT License.

---

Feel free to contribute or adjust the thresholds to fit your environment.
