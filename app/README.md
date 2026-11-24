# app/: the HQ system in PHP

## Run it
1. Copy the `app` folder's parent repo into XAMPP's `htdocs` (or clone it there), so this is `C:\xampp\htdocs\hygears-dba\app`.
2. Copy `config.example.php` to `config.php` and fill in your MySQL details (ignored by git).
3. Import the database (see `../database/README.md`).
4. Start Apache and MySQL, then open http://localhost/hygears-dba/app/

## Pages to build (from the prototypes)
`index.php` kiosk · `dashboard.php` · `attendance.php` · `people.php` · `items.php` · `requests.php` · `reports.php` · `settings.php`

## Rules for every page
- Include `includes/header.php` (set `$pageTitle` and `$activePage` first) and `includes/footer.php`.
- Get data with prepared statements on `$conn` from `includes/db.php`; print it with `htmlspecialchars()`.
- Officer pages need a login check; the door device should only use `index.php`.
- Check stock in PHP before approving a request (the database doesn't block over-approving).
