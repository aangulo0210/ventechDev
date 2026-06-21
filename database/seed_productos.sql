-- Seed: 20 productos por categoría (100 total)
-- Categorías: Celulares, Computadores, TV y Monitores, Audio, Periféricos
-- ~30% con descuento para que aparezcan en "Precios imperdibles"

USE ventech;

-- ─────────────────────────────────────────
-- CELULARES (20)
-- ─────────────────────────────────────────
INSERT INTO productos (nombre, marca, descripcion, categoria, precio, precio_anterior, descuento, emoji_referencia, activo) VALUES
('Galaxy S24 Ultra 256GB',        'Samsung',  'Pantalla Dynamic AMOLED 6.8", cámara 200MP, S Pen incluido.',                     'Celulares', 5200000, 5800000, 10, '📱', 1),
('iPhone 15 Pro 128GB',           'Apple',    'Chip A17 Pro, titanio, cámara 48MP, Dynamic Island.',                             'Celulares', 5900000, NULL,    0,  '📱', 1),
('Galaxy A55 128GB',              'Samsung',  'Pantalla Super AMOLED 6.6", batería 5000mAh, cámara triple.',                     'Celulares', 1850000, 2100000, 12, '📱', 1),
('Redmi Note 13 Pro 256GB',       'Xiaomi',   'Pantalla AMOLED 6.67", cámara 200MP, carga rápida 67W.',                         'Celulares', 1350000, NULL,    0,  '📱', 1),
('Moto G84 256GB',                'Motorola', 'Pantalla pOLED 6.5", cámara 50MP, batería 5000mAh.',                             'Celulares', 1100000, 1250000, 12, '📱', 1),
('iPhone 14 128GB',               'Apple',    'Chip A15 Bionic, cámara dual 12MP, pantalla Super Retina XDR.',                  'Celulares', 3900000, 4400000, 11, '📱', 1),
('Galaxy S23 FE 256GB',           'Samsung',  'Pantalla Dynamic AMOLED 6.4", chip Exynos 2200, resistencia IP68.',              'Celulares', 2200000, NULL,    0,  '📱', 1),
('Redmi 13C 128GB',               'Xiaomi',   'Procesador MediaTek Helio G85, cámara 50MP, batería 5000mAh.',                   'Celulares', 690000,  NULL,    0,  '📱', 1),
('POCO X6 Pro 256GB',             'Xiaomi',   'Pantalla AMOLED 6.67", chip Dimensity 8300, carga 67W.',                         'Celulares', 1750000, 1950000, 10, '📱', 1),
('Moto Edge 50 Pro 256GB',        'Motorola', 'Pantalla pOLED 144Hz, cámara 50MP OIS, carga inalámbrica 15W.',                  'Celulares', 2100000, NULL,    0,  '📱', 1),
('Galaxy Z Flip5 256GB',          'Samsung',  'Diseño plegable compacto, pantalla Flex 6.7" FHD+, bisagra Flex.',               'Celulares', 4800000, 5200000, 8,  '📱', 1),
('iPhone SE 3ra Gen 64GB',        'Apple',    'Chip A15 Bionic en formato compacto 4.7", Touch ID.',                            'Celulares', 2100000, NULL,    0,  '📱', 1),
('POCO M6 Pro 256GB',             'Xiaomi',   'Pantalla AMOLED 6.67", chip Helio G99 Ultra, cámara 64MP.',                     'Celulares', 1200000, 1380000, 13, '📱', 1),
('Galaxy A35 128GB',              'Samsung',  'Pantalla Super AMOLED 6.6" 120Hz, batería 5000mAh, cámara OIS.',                 'Celulares', 1450000, NULL,    0,  '📱', 1),
('Redmi 12 128GB',                'Xiaomi',   'Pantalla FHD+ 90Hz, cámara 50MP, batería 5000mAh, carga 18W.',                  'Celulares', 780000,  NULL,    0,  '📱', 1),
('Moto G54 5G 256GB',             'Motorola', 'Conectividad 5G, pantalla IPS 6.5" 120Hz, batería 6000mAh.',                    'Celulares', 1050000, 1200000, 13, '📱', 1),
('Galaxy F15 128GB',              'Samsung',  'Pantalla Super AMOLED 6.5", batería 6000mAh, carga 25W.',                       'Celulares', 720000,  NULL,    0,  '📱', 1),
('iPhone 15 256GB',               'Apple',    'Chip A16 Bionic, Dynamic Island, USB-C, cámara 48MP.',                           'Celulares', 4800000, NULL,    0,  '📱', 1),
('Tecno Spark 20 Pro 256GB',      'Tecno',    'Pantalla AMOLED 6.78" 120Hz, cámara 108MP, batería 5000mAh.',                   'Celulares', 950000,  1100000, 14, '📱', 1),
('Realme C67 128GB',              'Realme',   'Pantalla IPS 6.72" 120Hz, cámara 108MP, carga 67W SuperVOOC.',                  'Celulares', 880000,  NULL,    0,  '📱', 1);

-- ─────────────────────────────────────────
-- COMPUTADORES (20)
-- ─────────────────────────────────────────
INSERT INTO productos (nombre, marca, descripcion, categoria, precio, precio_anterior, descuento, emoji_referencia, activo) VALUES
('ThinkPad E15 Gen 4 i5 16GB',    'Lenovo',   'Intel Core i5-1235U, 16GB RAM, SSD 512GB, pantalla FHD 15.6".',                 'Computadores', 3200000, 3800000, 16, '💻', 1),
('MacBook Air M2 8GB 256GB',      'Apple',    'Chip M2, pantalla Liquid Retina 13.6", hasta 18h batería.',                     'Computadores', 6500000, NULL,    0,  '💻', 1),
('Inspiron 15 3000 i3 8GB',       'Dell',     'Intel Core i3-1115G4, 8GB RAM, SSD 256GB, pantalla FHD 15.6".',                 'Computadores', 1900000, 2200000, 14, '💻', 1),
('HP 250 G9 i5 8GB',              'HP',       'Intel Core i5-1235U, 8GB RAM, SSD 512GB, pantalla FHD 15.6".',                  'Computadores', 2600000, NULL,    0,  '💻', 1),
('IdeaPad Gaming 3 i5 16GB RTX', 'Lenovo',   'Intel i5-12450H, RTX 3050 4GB, 16GB RAM, SSD 512GB.',                          'Computadores', 4100000, 4600000, 11, '💻', 1),
('MacBook Pro M3 16GB 512GB',     'Apple',    'Chip M3, pantalla Liquid Retina XDR 14.2", ideal para diseño y video.',         'Computadores', 9800000, NULL,    0,  '💻', 1),
('Victus 16 i5 RTX 3050',         'HP',       'Intel Core i5-12450H, RTX 3050 4GB, 16GB RAM, SSD 512GB, pantalla 144Hz.',     'Computadores', 3900000, 4300000, 9,  '💻', 1),
('Vostro 15 3000 i5 16GB',        'Dell',     'Intel Core i5-1135G7, 16GB RAM, SSD 256GB, pantalla FHD antireflejo.',          'Computadores', 2900000, NULL,    0,  '💻', 1),
('ThinkBook 14 G6 i5 16GB',       'Lenovo',   'Intel Core i5-13500H, 16GB RAM, SSD 512GB, pantalla IPS 2.2K.',                'Computadores', 3500000, NULL,    0,  '💻', 1),
('Aspire 5 i5 8GB 512GB',         'Acer',     'Intel Core i5-1235U, 8GB RAM, SSD 512GB, pantalla IPS FHD 15.6".',             'Computadores', 2450000, 2750000, 11, '💻', 1),
('Swift Go 14 i5 OLED',           'Acer',     'Intel Core i5-1335U, pantalla OLED 2.8K 90Hz, 16GB LPDDR5, SSD 512GB.',       'Computadores', 3800000, NULL,    0,  '💻', 1),
('Nitro 5 i5 RTX 3050',           'Acer',     'Intel Core i5-12450H, RTX 3050, 16GB RAM, SSD 512GB, pantalla 144Hz.',         'Computadores', 4000000, 4500000, 11, '💻', 1),
('PC All-in-One 27" i5 16GB',     'HP',       'Intel Core i5, pantalla IPS 27" FHD, 16GB RAM, SSD 512GB.',                    'Computadores', 4200000, NULL,    0,  '💻', 1),
('Desktop OptiPlex 3000 i5',      'Dell',     'Intel Core i5-12500, 8GB RAM, SSD 256GB, factor de forma compacto.',            'Computadores', 2800000, 3100000, 10, '💻', 1),
('MiniPC IdeaCentre 510A',        'Lenovo',   'AMD Ryzen 5 5500U, 16GB RAM, SSD 512GB, compacto y silencioso.',               'Computadores', 2200000, NULL,    0,  '💻', 1),
('HP 15-fd0081 i5 12GB',          'HP',       'Intel Core i5-1335U, 12GB RAM, SSD 512GB, pantalla FHD antireflejo.',          'Computadores', 2750000, NULL,    0,  '💻', 1),
('Omen 16 i7 RTX 4060',           'HP',       'Intel Core i7-13700HX, RTX 4060 8GB, 16GB RAM, SSD 1TB, pantalla 165Hz.',     'Computadores', 7500000, 8200000, 9,  '💻', 1),
('MacBook Air M1 8GB 256GB',      'Apple',    'Chip M1, pantalla Retina 13.3", batería 18h, diseño ultrafino.',                'Computadores', 4900000, 5500000, 11, '💻', 1),
('IdeaPad Slim 5 AMD Ryzen 7',    'Lenovo',   'AMD Ryzen 7 7730U, 16GB RAM, SSD 512GB, pantalla IPS FHD 16".',                'Computadores', 3100000, NULL,    0,  '💻', 1),
('Inspiron 14 Plus i7 16GB',      'Dell',     'Intel Core i7-1360P, 16GB RAM, SSD 512GB, pantalla 2.5K IPS 14".',             'Computadores', 4400000, 4900000, 10, '💻', 1);

-- ─────────────────────────────────────────
-- TV Y MONITORES (20)
-- ─────────────────────────────────────────
INSERT INTO productos (nombre, marca, descripcion, categoria, precio, precio_anterior, descuento, emoji_referencia, activo) VALUES
('Smart TV QLED 55" 4K',          'Samsung',  'Quantum HDR, Tizen OS, Google Assistant, 4 puertos HDMI.',                      'TV y Monitores', 3200000, 3700000, 14, '🖥️', 1),
('Smart TV OLED 65" 4K',          'LG',       'Procesador α9 Gen6, ThinQ AI, Dolby Vision, Dolby Atmos.',                     'TV y Monitores', 7800000, NULL,    0,  '🖥️', 1),
('Monitor IPS 27" FHD 75Hz',      'HP',       'Pantalla IPS sin bordes, HDMI + VGA, ajuste de altura, brillo 250nits.',       'TV y Monitores', 620000,  720000,  14, '🖥️', 1),
('Monitor Gaming 27" 165Hz QHD',  'LG',       'Resolución 2560×1440, 1ms GtG, AMD FreeSync, panel IPS.',                     'TV y Monitores', 1450000, 1650000, 12, '🖥️', 1),
('Smart TV NEO QLED 65" 4K',      'Samsung',  'Quantum Mini LED, procesador Neural Quantum, Gaming Hub, 144Hz.',              'TV y Monitores', 8500000, NULL,    0,  '🖥️', 1),
('Monitor 24" FHD IPS 100Hz',     'Dell',     'Panel IPS antireflejo, USB-C, HDMI, DisplayPort, ajuste VESA.',                'TV y Monitores', 780000,  NULL,    0,  '🖥️', 1),
('TV Crystal UHD 43" 4K',         'Samsung',  'Crystal Processor 4K, PurColor, HDR, Smart TV Tizen.',                         'TV y Monitores', 1800000, 2100000, 14, '🖥️', 1),
('Monitor OLED 27" 240Hz',        'LG',       'Panel OLED 2560×1440, 0.03ms, G-Sync Compatible, USB-C 90W.',                 'TV y Monitores', 2800000, NULL,    0,  '🖥️', 1),
('Smart TV 50" 4K UHD Google TV', 'TCL',      'Google TV integrado, Dolby Audio, HDR10, 3 HDMI, 2 USB.',                     'TV y Monitores', 1500000, 1750000, 14, '🖥️', 1),
('Monitor 32" 4K IPS USB-C',      'HP',       'Resolución 3840×2160, USB-C 65W, DisplayPort, HDMI, calibración sRGB 99%.',   'TV y Monitores', 2200000, NULL,    0,  '🖥️', 1),
('Smart TV 55" OLED A3',          'LG',       'OLED evo, α7 Gen6 AI, HDMI 2.1, VRR, ALLM, webOS 23.',                       'TV y Monitores', 5500000, 6200000, 11, '🖥️', 1),
('Monitor Curvo 34" WQHD 100Hz',  'Samsung',  'Panel VA curvo 3440×1440, AMD FreeSync, HDMI, DisplayPort.',                  'TV y Monitores', 1800000, NULL,    0,  '🖥️', 1),
('TV 4K 65" Fire TV Edition',     'Insignia', 'Alexa integrada, HDR, Dolby Digital Plus, múltiples apps nativas.',            'TV y Monitores', 2100000, 2400000, 13, '🖥️', 1),
('Monitor Gaming 24" 144Hz',      'Acer',     'Panel IPS 1080p 144Hz, AMD FreeSync, ZeroFrame, HDMI + DP.',                  'TV y Monitores', 750000,  NULL,    0,  '🖥️', 1),
('Smart TV 43" 4K Android TV',    'TCL',      'Android TV, Chromecast integrado, Google Assistant, Dolby Audio.',             'TV y Monitores', 1200000, 1400000, 14, '🖥️', 1),
('Monitor 27" 4K IPS 60Hz',       'Dell',     'Resolución UHD, panel IPS, HDMI 2.0, DisplayPort 1.4, USB Hub.',              'TV y Monitores', 1650000, NULL,    0,  '🖥️', 1),
('Smart TV QLED 75" 4K',          'Samsung',  'QLED 4K, procesador Quantum 4K, Motion Xcelerator Turbo+, Gaming Hub.',       'TV y Monitores', 9200000, 10000000,8,  '🖥️', 1),
('Monitor 21.5" FHD VA 75Hz',     'HP',       'Panel VA FHD, HDMI, VGA, diseño compacto para escritorio pequeño.',           'TV y Monitores', 480000,  550000,  13, '🖥️', 1),
('Smart TV 32" FHD Android',      'LG',       'Procesador Quad Core, ThinQ AI, HDMI, magic remote compatible.',              'TV y Monitores', 850000,  NULL,    0,  '🖥️', 1),
('Monitor Gaming 27" 240Hz IPS',  'Acer',     'IPS 1920×1080, 240Hz, 1ms IPS, G-Sync Compatible, HDMI 2.0.',                'TV y Monitores', 1350000, 1550000, 13, '🖥️', 1);

-- ─────────────────────────────────────────
-- AUDIO (20)
-- ─────────────────────────────────────────
INSERT INTO productos (nombre, marca, descripcion, categoria, precio, precio_anterior, descuento, emoji_referencia, activo) VALUES
('WH-1000XM5 ANC Bluetooth',      'Sony',     'Cancelación de ruido líder, 30h batería, micrófono beamforming.',              'Audio', 1200000, 1400000, 14, '🎧', 1),
('QuietComfort 45 ANC',           'Bose',     'ANC ajustable, sonido balanceado, 24h batería, USB-C, plegable.',              'Audio', 1350000, NULL,    0,  '🎧', 1),
('Galaxy Buds2 Pro TWS',          'Samsung',  'ANC inteligente, audio Hi-Fi 24bit, resistencia IPX7, 5h batería.',            'Audio', 780000,  900000,  13, '🎧', 1),
('AirPods Pro 2da Gen',           'Apple',    'Chip H2, ANC adaptativa, Audio Espacial, resistencia IP54.',                   'Audio', 1100000, NULL,    0,  '🎧', 1),
('SoundBar HW-Q60C 3.1',          'Samsung',  'Dolby Atmos, DTS:X, Acoustic Beam, modo juego, HDMI eARC.',                   'Audio', 1600000, 1900000, 16, '🔊', 1),
('Bocina Bluetooth UE Boom 3',    'Ultimate Ears', 'Resistencia IP67, 360° sonido, 15h batería, flotante en agua.',          'Audio', 650000,  NULL,    0,  '🔊', 1),
('Auriculares WH-CH720N ANC',     'Sony',     'ANC, Bluetooth 5.2, 35h batería, diseño ultraligero 192g.',                   'Audio', 620000,  720000,  14, '🎧', 1),
('Headset Cloud Alpha Gaming',    'HyperX',   'Drivers DTS, micrófono desmontable, sonido 7.1 virtual, USB.',                'Audio', 480000,  NULL,    0,  '🎧', 1),
('Barra de Sonido 2.1 650W',      'LG',       'Meridian Audio, DTS Virtual:X, Bluetooth, HDMI ARC, subwoofer inalámbrico.',  'Audio', 1800000, 2100000, 14, '🔊', 1),
('Audífonos Gaming GSP 300',      'Sennheiser','Cápsula de 40mm, micrófono flexible, almohadillas de piel, PC/consola.',     'Audio', 420000,  NULL,    0,  '🎧', 1),
('TWS Soundcore P40i ANC',        'Anker',    'ANC híbrido, 60h autonomía total, carga rápida 10min = 2h.',                  'Audio', 290000,  350000,  17, '🎧', 1),
('Bocina Bluetooth Charge 5',     'JBL',      'Carga de dispositivos, 20h batería, resistencia IP67, sonido JBL Pro.',       'Audio', 780000,  NULL,    0,  '🔊', 1),
('Auriculares ATH-M50xBT2',       'Audio-Technica','Bluetooth 5.0, ANC, 50h batería, plegable, monitoreo profesional.',     'Audio', 750000,  870000,  14, '🎧', 1),
('Home Theater 5.1 HT-S400',      'Sony',     'Dolby Digital, 330W RMS, HDMI ARC, Bluetooth, subwoofer activo.',            'Audio', 2200000, NULL,    0,  '🔊', 1),
('Bocina Go 3s Bluetooth',        'JBL',      'Resistencia IP67, 5h batería, diseño compacto, varios colores.',              'Audio', 195000,  230000,  15, '🔊', 1),
('Auriculares Tune 770NC',        'JBL',      'ANC adaptativo, 70h batería, Bluetooth 5.3, plegable, multipoint.',           'Audio', 450000,  NULL,    0,  '🎧', 1),
('Micrófono Blue Yeti USB',       'Logitech', 'Patrón polar cuádruple, 24bit/192kHz, ideal para streaming y podcast.',       'Audio', 520000,  620000,  16, '🎙️', 1),
('Soundbar Flex Portátil',        'Samsung',  'Wi-Fi, Bluetooth, batería incorporada, Dolby 5.1, compatible TV Samsung.',    'Audio', 1100000, NULL,    0,  '🔊', 1),
('TWS Pixel Buds Pro',            'Google',   'ANC, modo transparencia, Audio Espacial, resistencia IPX4, 7h batería.',      'Audio', 850000,  980000,  13, '🎧', 1),
('Auriculares Over-Ear H9i ANC',  'Philips',  'ANC híbrido, Hi-Res Audio, 30h batería, USB-C, almohadillas memory foam.',   'Audio', 380000,  NULL,    0,  '🎧', 1);

-- ─────────────────────────────────────────
-- PERIFÉRICOS (20)
-- ─────────────────────────────────────────
INSERT INTO productos (nombre, marca, descripcion, categoria, precio, precio_anterior, descuento, emoji_referencia, activo) VALUES
('Teclado MX Keys S Inalámbrico', 'Logitech', 'Retroiluminado, Bluetooth multi-dispositivo, batería 10 días, teclas perfectas.','Periféricos', 420000, 490000,  14, '⌨️', 1),
('Mouse MX Master 3S',            'Logitech', '8000 DPI, MagSpeed, Bluetooth, 70 días batería, compatible cualquier superficie.','Periféricos', 380000, NULL,    0,  '🖱️', 1),
('Teclado Mecánico K70 RGB MK.2', 'Corsair',  'Switches Cherry MX Red, RGB por tecla, reposa muñecas, USB.',                  'Periféricos', 580000, 660000,  12, '⌨️', 1),
('Mouse Gaming DeathAdder V3',    'Razer',    '30000 DPI, 90h batería, 6 botones, diseño ergonómico, HyperSpeed.',            'Periféricos', 450000, NULL,    0,  '🖱️', 1),
('Webcam C920 FHD 1080p',         'Logitech', 'Full HD 1080p 30fps, micrófono estéreo, corrección de luz automática.',        'Periféricos', 320000, 380000,  16, '📷', 1),
('Hub USB-C 7 en 1',              'Anker',    'HDMI 4K, 3× USB-A, USB-C PD 100W, SD/microSD, compatible MacBook y portátil.','Periféricos', 210000, NULL,    0,  '🔌', 1),
('Teclado + Mouse Combo MK470',   'Logitech', 'Combo inalámbrico silencioso, receptor nano USB, batería 36 meses.',           'Periféricos', 280000, 320000,  13, '⌨️', 1),
('Mouse Vertical Lift M800',      'Logitech', 'Ergonómico vertical, Bluetooth, 4000 DPI, 4 meses batería, reduce fatiga.',    'Periféricos', 340000, NULL,    0,  '🖱️', 1),
('Mousepad XL Desk Mat',          'SteelSeries','Base antideslizante, superficie texturizada, 900×300mm, costuras bordadas.', 'Periféricos', 120000, 145000,  17, '🖱️', 1),
('Teclado Mecánico TKL K65',      'Corsair',  'Formato TKL compacto, switches Cherry MX Speed, retroiluminado RGB.',         'Periféricos', 490000, NULL,    0,  '⌨️', 1),
('Impresora Multifuncional M140W', 'Epson',   'Inyección de tinta B/N, Wi-Fi, escaner, copiadora, bajo costo por página.',   'Periféricos', 450000, 530000,  15, '🖨️', 1),
('Mouse Gaming G502 X PLUS',      'Logitech', 'LIGHTFORCE híbrido, 100h batería, 13 botones, HERO 25K DPI sensor.',          'Periféricos', 520000, NULL,    0,  '🖱️', 1),
('Teclado Inalámbrico K380',      'Logitech', 'Bluetooth multi-dispositivo, teclas redondas, compacto, batería 2 años.',     'Periféricos', 195000, 230000,  15, '⌨️', 1),
('Docking Station USB-C 12 en 1', 'Anker',   'Triple pantalla, 2× HDMI, 1× DP, 4× USB, SD, Ethernet, PD 85W.',             'Periféricos', 480000, NULL,    0,  '🔌', 1),
('Teclado Gaming K100 RGB',       'Corsair',  'Switches OPX ópticos, rueda de control iCUE, aluminio, 4000Hz polling.',     'Periféricos', 890000, 1000000, 11, '⌨️', 1),
('Mouse Ergonómico Sculpt',       'Microsoft','Diseño ergonómico curvo, receptor nano USB, 4 meses batería, Windows.',       'Periféricos', 260000, NULL,    0,  '🖱️', 1),
('Impresora Láser M404N',         'HP',       'Láser monocromo, 38ppm, USB + Ethernet, hasta 4800 páginas/mes.',             'Periféricos', 1100000, 1250000, 12, '🖨️', 1),
('Webcam StreamCam 1080p 60fps',  'Logitech', 'Full HD 60fps, USB-C, IA de encuadre, streaming y videollamadas pro.',        'Periféricos', 480000, NULL,    0,  '📷', 1),
('Mouse Pad Pro XL LED RGB',      'Redragon', 'Base antideslizante, iluminación RGB 14 efectos, 900×400mm, USB.',            'Periféricos', 95000,  115000,  17, '🖱️', 1),
('Teclado Mecánico K552 TKL RGB', 'Redragon', 'Switches Outemu Blue táctiles, RGB, formato TKL compacto, USB.',             'Periféricos', 180000, NULL,    0,  '⌨️', 1);

-- ─────────────────────────────────────────
-- INVENTARIO — todos los productos insertados
-- Detecta el rango de IDs automáticamente
-- ─────────────────────────────────────────
INSERT INTO inventario (id_producto, stock_actual, stock_minimo)
SELECT id, FLOOR(10 + RAND() * 91), 5
FROM productos
WHERE id NOT IN (SELECT id_producto FROM inventario);
