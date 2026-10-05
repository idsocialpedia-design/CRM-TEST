# CRM Open Source (Supabase + Cloudinary + Vercel)

Situs statis tanpa build. Supabase menjadi backend (database, auth, RLS), Cloudinary menyimpan foto dan lampiran.

## 1. Supabase
1. Buat proyek di supabase.com (paket gratis).
2. Buka **SQL Editor**, tempel isi `schema.sql`, lalu **Run**.
3. Buka **Project Settings > API**, salin **Project URL** dan **anon public key**.
4. (Opsional) **Authentication > Providers > Email**: matikan "Confirm email" agar bisa langsung masuk saat uji coba.

## 2. Cloudinary
1. Buat akun gratis di cloudinary.com, catat **Cloud name**.
2. **Settings > Upload > Upload presets > Add**, ubah **Signing mode** menjadi **Unsigned**, simpan, catat nama preset.

## 3. Konfigurasi
Edit `config.js` dan isi keempat nilai. Jangan masukkan service_role key atau API secret.

## 4. GitHub dan Vercel
```bash
git init && git add . && git commit -m "CRM awal"
git branch -M main
git remote add origin https://github.com/USERNAME/crm.git
git push -u origin main
```
Di vercel.com pilih **Add New > Project**, impor repo, Framework Preset **Other**, lalu **Deploy**. Setiap `git push` akan deploy otomatis.

Setelah deploy, tambahkan URL Vercel Anda di Supabase: **Authentication > URL Configuration > Site URL**.

## Keamanan
Row Level Security aktif, jadi setiap pengguna hanya melihat datanya sendiri. Upload Cloudinary unsigned dibatasi oleh preset (batasi format dan ukuran file di pengaturan preset).

## Pengembangan lanjutan
Tim dengan data bersama (tabel organisasi dan anggota), email otomatis (Resend atau Brevo plan gratis lewat Vercel Functions), webhook WhatsApp, dan Supabase Realtime.
