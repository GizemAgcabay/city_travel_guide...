const imageBase = "https://upload.wikimedia.org/wikipedia/commons/";
const seyhanPhoto = imageBase + "0/08/Adana_Sabanc%C4%B1_Merkez_Camii_ve_Seyhan_Nehri.jpg";
const places = {
    taskopru: {
        name: "Taşköprü",
        category: "Tarihi miras",
        image: imageBase + "d/d6/Ta%C5%9F_K%C3%B6pr%C3%BC_Adana.jpg",
        lead: "Seyhan Nehri'nin iki yakasını buluşturan tarihi köprü.",
        description: "Taşköprü, Seyhan Nehri üzerinde Adana'nın iki yakasını birbirine bağlayan, Roma dönemine uzanan tarihi bir köprüdür. Köprünün taş kemerlerini nehir kıyısından, Seyhan Nehri’ni ve Sabancı Merkez Camii’ni ise köprü üzerinden görebilirsin. Buradan nehir kıyısına inerek yürüyüşüne devam edebilirsin.",
        highlights: ["Taş kemerleri", "Seyhan Nehri manzarası", "Yakındaki Sabancı Merkez Camii"],
        location: "Seyhan Nehri, Adana şehir merkezi",
        transport: "Şehir merkezinden yürüyerek veya toplu taşımayla ulaşılabilir.",
        tip: "Yaz aylarında günün serin saatlerinde ziyaret edebilirsin."
    },
    buyuksaat: {
        name: "Büyük Saat",
        category: "Tarihi miras",
        image: imageBase + "e/ed/B%C3%BCy%C3%BCk_Saat_Adana_Turkey.jpg",
        lead: "Tarihi şehir merkezinde yükselen tuğla saat kulesi.",
        description: "Büyük Saat, Osmanlı döneminde inşa edilen ve Adana’nın tarihi çarşısında yükselen bir saat kulesidir. Dar sokakların arasından görünen kule, tuğla gövdesi ve üst bölümündeki saat kadranlarıyla çevresindeki yapılardan ayrılır. Kulenin dışını gördükten sonra çarşı sokaklarında dolaşabilir ve yakındaki Ulu Cami Külliyesi’ne yürüyebilirsin.",
        highlights: ["Tuğla işçiliği", "Tarihi çarşı", "Yakındaki Ulu Cami"],
        location: "Ali Münif Yeğenağa Caddesi, Seyhan, Adana",
        transport: "Çarşı ve Ulu Cami çevresinden yürüyerek ulaşılabilir.",
        tip: "Ziyaretini çevredeki tarihi çarşılarla birleştirebilirsin."
    },
    "seyhan-nehri": {
        name: "Seyhan Nehri Kıyısı",
        category: "Nehir",
        image: seyhanPhoto,
        lead: "Seyhan Nehri boyunca şehir manzarası eşliğinde yürüyüş yap.",
        description: "Seyhan Nehri’nin şehir merkezinden geçen bölümü, Adana’nın tarihi yapılarını kıyıdan izleyebileceğin bir yürüyüş güzergâhı sunar. Taşköprü çevresinde köprünün kemerlerini görebilir, Merkez Park yönünde ilerledikçe Sabancı Merkez Camii’ni nehir manzarasıyla birlikte izleyebilirsin. Taşköprü, cami ve parkı aynı yürüyüşe dahil edebilirsin.",
        highlights: ["Nehir kıyısında yürüyüş", "Taşköprü manzarası", "Merkez Park bağlantısı"],
        location: "Taşköprü ve Merkez Park çevresi, Adana",
        transport: "Taşköprü veya Merkez Park tarafından yürüyerek ulaşılabilir.",
        tip: "Öğle sıcağında gölgeli alanları tercih edebilirsin."
    },
    park: {
        name: "Merkez Park",
        category: "Park",
        image: imageBase + "b/ba/Adana_Merkez_Park_02.jpg",
        lead: "Seyhan kıyısında yürüyüş ve dinlenme alanları.",
        description: "Merkez Park, Seyhan Nehri kıyısına yayılan geniş bir şehir parkıdır. Parkın içindeki yürüyüş yolları yeşil alanlardan geçer, nehir kıyısına yaklaştığında ise Sabancı Merkez Camii manzarası açılır. Burada yürüyüş yapabilir, çim alanlarda mola verebilir veya gezine nehir kıyısından devam edebilirsin.",
        highlights: ["Yürüyüş yolları", "Yeşil dinlenme alanları", "Sabancı Merkez Camii manzarası"],
        location: "Reşatbey Mahallesi, Seyhan, Adana",
        transport: "Sabancı Merkez Camii ve nehir kıyısından yürüyerek ulaşılabilir.",
        tip: "Etkinlikler nedeniyle parkın bazı bölümleri geçici olarak kapanabilir."
    },
    museum: {
        name: "Adana Arkeoloji Müzesi",
        category: "Müze",
        image: imageBase + "d/d2/Adana_Archaeology_Museum.jpeg",
        lead: "Çukurova'nın geçmişini arkeolojik eserlerle tanı.",
        description: "Adana Arkeoloji Müzesi, Çukurova’da yaşamış toplumların geçmişini farklı dönemlere ait buluntular üzerinden anlatır. Koleksiyonda seramik kaplar, heykeller, lahitler ve taş eserler yer alır. Eserlerin açıklamalarını okuyarak bölgede gündelik yaşamın, sanatın ve gömü geleneklerinin zaman içinde nasıl değiştiğini görebilirsin.",
        highlights: ["Bölgeden arkeolojik eserler", "Taş eserler", "Çukurova tarihi"],
        location: "Döşeme Mahallesi, Seyhan, Adana",
        transport: "Ulaşım ve güncel adres için resmî müze bilgilerini kontrol et.",
        tip: "Açık sergi alanlarını ziyaret öncesi kontrol edebilirsin."
    },
    sabanci: {
        name: "Sabancı Merkez Camii",
        category: "Cami",
        image: seyhanPhoto,
        lead: "Seyhan kıyısındaki altı minareli cami.",
        description: "1998’de ibadete açılan Sabancı Merkez Camii, Seyhan Nehri kıyısındaki konumu ve altı minaresiyle Adana’nın şehir siluetinde öne çıkar. Büyük merkezi kubbesini ve minarelerini Merkez Park’tan bir arada görebilirsin. Caminin çevresini gezdikten sonra parkta mola verebilir veya nehir kıyısı boyunca Taşköprü yönüne yürüyebilirsin.",
        highlights: ["Altı minareli mimari", "Seyhan Nehri manzarası", "Yakındaki Merkez Park"],
        location: "Reşatbey Mahallesi, Seyhan, Adana",
        transport: "Merkez Park ve nehir kıyısından yürüyerek ulaşılabilir.",
        tip: "Ziyaret sırasında ibadet düzenine ve kıyafet kurallarına dikkat et."
    },
    ulu: {
        name: "Ulu Cami Külliyesi",
        category: "Cami",
        image: imageBase + "7/74/Adana_Ulu_Cami_Exterior_from_northwest_4997.jpg",
        lead: "Taş işçiliği ve çinileriyle öne çıkan tarihi külliye.",
        description: "Ulu Cami Külliyesi, Ramazanoğulları döneminden kalan ve Adana’nın tarihi merkezinde yer alan bir yapı topluluğudur. Caminin girişlerindeki iki renkli taş işçiliği ve iç mekânındaki çiniler, yapının dikkat çeken ayrıntılarıdır. Büyük Saat ve tarihi çarşıya yakın olduğu için külliyeyi aynı yürüyüş rotasında ziyaret edebilirsin.",
        highlights: ["Taş işçiliği", "Çini detayları", "Yakındaki Büyük Saat"],
        location: "Ali Münif Yeğenağa Caddesi, Seyhan, Adana",
        transport: "Büyük Saat ve tarihi çarşı çevresinden yürüyerek ulaşılabilir.",
        tip: "Cami ibadete açıktır. Ziyaret kurallarına dikkat et."
    }
};

const groups = {
    "tarihi-yapilar": ["Tarihi Yapılar", "taskopru", "buyuksaat"],
    "nehir-ve-parklar": ["Nehir ve Parklar", "seyhan-nehri", "park"],
    "muzeler-ve-camiler": ["Müzeler ve Camiler", "museum", "sabanci", "ulu"]
};
const get = (id) => document.getElementById(id);
const isPhoto = (url) => /^https?:\/\//i.test(url);
const storageKey = "adana-gezi-onerileri";
const details = get("place-details");
const groupList = get("place-groups");
const gallery = get("suggested-places");

function element(tag, text = "", className = "") {
    const item = document.createElement(tag);
    item.textContent = text;
    item.className = className;
    return item;
}
function readSuggestions() {
    const saved = JSON.parse(localStorage.getItem(storageKey) || "[]");
    return Array.isArray(saved) ? saved : [];
}
function card(id, place) {
    const link = element("a", "", "place-card");
    link.href = "details.html#" + encodeURIComponent(id);
    if (isPhoto(place.image)) {
        const photo = element("img");
        photo.src = place.image;
        photo.alt = "";
        photo.loading = "lazy";
        link.append(photo);
    }
    const info = element("div", "", "place-info");
    info.append(element("p", place.category, "eyebrow"), element("h3", place.name),
        element("p", place.lead || place.description), element("span", "Detayları gör →", "card-label"));
    link.append(info);
    return link;
}
function addDetail(id, place) {
    const article = get("detail-template").content.firstElementChild.cloneNode(true);
    article.id = id;
    const photo = article.querySelector("img");
    if (isPhoto(place.image)) {
        photo.src = place.image;
        photo.alt = place.name;
        photo.hidden = false;
    }
    const fields = { ...place, lead: place.lead || "Ziyaretçi önerisi",
        location: place.location || place.address + ", " + place.city,
        tip: place.tip || "Öneren kişi: " + place.sender };
    for (const field of article.querySelectorAll("[data-field]")) {
        field.textContent = fields[field.dataset.field] || "";
    }
    const list = article.querySelector("ul");
    for (const text of place.highlights || []) list.append(element("li", text));
    article.querySelector(".highlights").hidden = !list.children.length;
    article.querySelector(".transport").hidden = !place.transport;
    article.querySelector(".text-button").hidden = !Object.hasOwn(places, id);
    article.querySelector(".text-button").href = "fees-hours.html#" + id;
    details.append(article);
}
for (const [id, [title, ...ids]] of Object.entries(groups)) {
    if (groupList) {
        const section = element("section", "", "place-group");
        const grid = element("div", "", "places-grid");
        section.id = id;
        for (const placeId of ids) grid.append(card(placeId, places[placeId]));
        section.append(element("h2", title), grid);
        groupList.append(section);
    }
    if (details) for (const placeId of ids) addDetail(placeId, places[placeId]);
}
try {
    for (const place of readSuggestions()) {
        if (gallery) {
            gallery.append(card(place.id, place));
            get("suggestions-empty").hidden = true;
        }
        if (details) addDetail(place.id, place);
    }
} catch {
    if (gallery) get("suggestions-empty").textContent = "Öneriler okunamadı.";
}
if (details) {
    const id = location.hash.slice(1) || new URLSearchParams(location.search).get("id");
    const target = get(id);
    if (target && details.contains(target)) target.scrollIntoView();
}
const today = get("today-date");
if (today) {
    const format = new Intl.DateTimeFormat("tr-TR", { dateStyle: "long", timeZone: "Europe/Istanbul" });
    const showDate = () => { today.textContent = format.format(new Date()); };
    showDate();
    get("today-line").hidden = false;
    setInterval(showDate, 30000);
}
const form = get("suggestion-form");
if (form) form.onsubmit = (event) => {
    event.preventDefault();
    const data = new FormData(form);
    const value = (name) => data.get(name).trim();
    const place = {
        id: "oneri-" + Date.now() + "-" + Math.random().toString(36).slice(2),
        name: value("placeName"), city: value("city"), address: value("address"),
        category: value("category"), description: value("description"),
        image: value("imageUrl"), sender: value("senderName")
    };
    const message = get("form-message");
    const link = get("saved-link");
    link.hidden = true;
    if (!place.name || !place.city || !place.address || !place.description || !place.sender ||
        (place.image && !isPhoto(place.image))) {
        message.textContent = "Boş alanları ve görsel adresini kontrol et.";
        return;
    }
    message.textContent = "";
    const summary = [place.name, place.city + " · " + place.address, place.category,
        place.description, place.image, "Öneren: " + place.sender, "Öneriyi kaydedelim mi?"];
    if (!window.confirm(summary.filter(Boolean).join("\n\n"))) return;
    try {
        localStorage.setItem(storageKey, JSON.stringify([...readSuggestions(), place]));
    } catch {
        message.textContent = "Öneri bu tarayıcıya kaydedilemedi.";
        return;
    }
    form.reset();
    message.textContent = "Önerin bu tarayıcıda kaydedildi.";
    link.hidden = false;
};
const placeSearch = document.getElementById("place-search");

if (placeSearch) {
    placeSearch.addEventListener("input", () => {
        const query = placeSearch.value.trim().toLocaleLowerCase("tr");

        document.querySelectorAll("#place-groups .place-card").forEach((card) => {
            const name = card.querySelector("h3").textContent.toLocaleLowerCase("tr");
            card.style.display = name.includes(query) ? "" : "none";
        });
    });
}
const hero = document.querySelector(".hero");
const photoDots = document.querySelectorAll(".hero-photo-controls button");

if (hero && photoDots.length) {
    const photos = ["", places.buyuksaat.image, places.sabanci.image];
    let currentPhoto = 0;

    function showPhoto(index) {
        currentPhoto = index;
        const photo = photos[index];

        if (photo) {
            hero.style.setProperty("--hero-photo", `url("${photo}")`);
        } else {
            hero.style.removeProperty("--hero-photo");
        }

        photoDots.forEach((dot, position) => {
            dot.setAttribute("aria-pressed", String(position === index));
        });
    }

    photoDots.forEach((dot, index) => {
        dot.addEventListener("click", () => showPhoto(index));
    });

    if (!window.matchMedia("(prefers-reduced-motion: reduce)").matches) {
        setInterval(() => showPhoto((currentPhoto + 1) % photos.length), 5000);
    }
}