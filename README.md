# Português para o Brasil

Сайт с планом изучения бразильского португальского: 48 недель по 20 минут в день, два профиля (Антон и Янина), общий прогресс в базе Supabase.

## Запуск на компьютере

```bash
python3 -m http.server 8000
```

Открыть http://localhost:8000

## Подключение базы (один раз)

1. На supabase.com создать проект.
2. SQL Editor → вставить `supabase.sql` → Run.
3. Settings → API: скопировать Project URL и anon public key в `config.js`.

## Публикация

Сайт размещён на GitHub Pages. Изменения попадают на сайт после push в `main`.
