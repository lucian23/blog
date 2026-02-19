# Blog Identitate Digitală

Un blog static construit cu Jekyll, despre identitate digitală, securitate online și tehnologii emergente.

## 🌐 Live Site

Site-ul este găzduit pe GitHub Pages:  
**https://lucian23.github.io/blog/**

## 📖 Conținut

Blogul conține 10 articole despre identitate digitală:

1. Ce este identitatea digitală și de ce este importantă?
2. Cum să obții un ID Digital Sigur
3. Protecția datelor personale în era digitală
4. Semnătura electronică - tot ce trebuie să știi
5. SPV - Spațiul Privat Virtual al României
6. Manageri de parole - necesitate, nu opțiune
7. Autentificarea cu doi factori (2FA) - scutul tău digital
8. Identitatea digitală pentru antreprenori
9. Viitorul identității digitale - blockchain și Self-Sovereign Identity
10. Ghid practic: Cum îți organizezi identitatea digitală

## 🛠️ Tehnologii

- **Jekyll** - Generator site static
- **GitHub Pages** - Hosting
- **Markdown** - Format articole
- **HTML/CSS** - Frontend
- **Minima** - Temă Jekyll

## 🚀 Instalare și Rulare Locală

### Cerințe
- Ruby 2.5.0 sau mai nou
- RubyGems
- GCC și Make

### Pași de instalare

```bash
# Clonează repository-ul
git clone https://github.com/lucian23/blog.git
cd blog

# Instalează dependențele
bundle install

# Rulează serverul local
bundle exec jekyll serve

# Deschide browserul la
http://localhost:4000/blog/
```

## 📁 Structura Proiectului

```
.
├── _config.yml          # Configurație Jekyll
├── _layouts/            # Template-uri
│   ├── default.html     # Layout principal
│   └── post.html        # Layout articole
├── _posts/              # Articolele blogului (10 articole)
├── assets/css/          # Stiluri CSS
├── index.html           # Pagina principală
├── despre.md            # Pagina "Despre"
├── contact.md           # Pagina "Contact"
└── README.md            # Acest fișier
```

## ✍️ Adăugarea de Articole Noi

Pentru a adăuga un articol nou:

1. Creează un fișier în `_posts/` cu formatul: `YYYY-MM-DD-titlu-articol.md`
2. Adaugă front matter:
```yaml
---
layout: post
title: "Titlul Articolului"
date: YYYY-MM-DD HH:MM:SS +0200
author: Lucian
categories: [categorie]
tags: [tag1, tag2]
---
```
3. Scrie conținutul în Markdown
4. Commit și push

## 🎨 Personalizare

### Modificarea Culorilor
Editează `assets/css/style.css` pentru a schimba schema de culori.

### Modificarea Configurației
Editează `_config.yml` pentru a schimba:
- Titlul site-ului
- Descrierea
- Informații autor
- Alte setări Jekyll

## 🤝 Contribuții

Contribuțiile sunt binevenite! Pentru a contribui:

1. Fork repository-ul
2. Creează un branch pentru feature-ul tău (`git checkout -b feature/amazing-feature`)
3. Commit modificările (`git commit -m 'Add amazing feature'`)
4. Push la branch (`git push origin feature/amazing-feature`)
5. Deschide un Pull Request

## 📄 Licență

Acest proiect este open source și disponibil sub licența [MIT](LICENSE).

## 📧 Contact

- **Autor:** Lucian
- **Email:** leica.lucian.QvreauID@blogger.com
- **GitHub:** [lucian23](https://github.com/lucian23)

---

*Creat cu ❤️ pentru comunitatea interesată de identitate digitală și securitate online.*