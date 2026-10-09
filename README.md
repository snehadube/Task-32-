# OTT Content Trend Analysis (Netflix)

Netflix ke catalog ka trend analysis: kaun se genre, country aur release years ka content zyada hai, aur movie ki length kaise badli.

**Dataset:** Netflix Movies and TV Shows (8,807 titles) aur Amazon Prime titles (9,668 titles), dono Kaggle se, data 2021 tak.
**Tools:** Python (pandas, seaborn, matplotlib, plotly), SQLite (aggregations and a JOIN), Excel pivot.

## Kya mila
- Catalog mein lagbhag 70% Movies aur 30% TV Shows hain, par naye releases mein TV Shows ka share badh raha hai (2015 mein ~29%, 2020 mein ~46%).
- Dramas (1600) aur Comedies (1210) sabse bade genres hain. US ke baad India (1008 titles) doosre number par hai.
- Movies chhoti ho rahi hain: 2000-02 mein ~115-119 min, 2020 mein ~92 min.

## Files
- `netflix_analysis.ipynb` - cleaning + 7 charts + SQL
- `queries.sql` - 9 SQL queries (JOIN aur Netflix vs Prime ke queries)
- `netflix_pivot_backup.xlsx` - release year x type pivot aur chart
- `Content_Strategy_Memo.docx` - 3 insights aur recommendations
- `Project_Report.pdf` - poori project report

- Prime vs Netflix: Prime zyada movie-heavy hai (81% vs 70%) aur uski movies chhoti hain (91 vs 100 min). Netflix mein comedy aur documentary zyada hain.

## Limitations
Prime data mein country aur date_added bahut kam bhari hain, isliye country analysis sirf Netflix ka hai. Har title ka sirf pehla country aur pehla genre liya gaya hai. 2021 ka data adhura hai.
