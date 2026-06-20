import '../../assets/food/food_assets.dart';
import 'food_item.dart';

abstract final class FoodMenuData {
  FoodMenuData._();

  static final items = <FoodItem>[
    // Polish — starters
    FoodItem(
      culture: FoodCulture.polish,
      course: FoodCourse.starter,
      name: 'Żurek',
      description:
          'A comforting sour rye soup, often served in a bread bowl or cup '
          'with smoked sausage, hard-boiled egg, and marjoram — a classic '
          'Polish wedding starter.',
      contains:
          'Sour rye starter, pork stock, smoked sausage (kiełbasa), '
          'hard-boiled egg, potato, marjoram, garlic.',
      allergens: 'Gluten, eggs, pork. May contain dairy.',
      spiceLevel: 'Mild',
      wikipediaUrl: 'https://en.wikipedia.org/wiki/%C5%BBurek',
      imageAsset: FoodAssets.polish('zurek'),
    ),
    FoodItem(
      culture: FoodCulture.polish,
      course: FoodCourse.starter,
      name: 'Barszcz z Uszkami',
      description:
          'Deep ruby beetroot soup with delicate mushroom-filled dumplings — '
          'light, earthy, and traditional for festive tables.',
      contains:
          'Beetroot, vegetable stock, uszka dumplings (wheat flour, '
          'mushrooms, onion), lemon, sugar, salt.',
      allergens: 'Gluten, eggs. May contain dairy.',
      spiceLevel: 'Mild',
      wikipediaUrl: 'https://en.wikipedia.org/wiki/Barszcz',
      imageAsset: FoodAssets.polish('barszcz'),
    ),
    FoodItem(
      culture: FoodCulture.polish,
      course: FoodCourse.starter,
      name: 'Łosoś z Koperkiem',
      description:
          'Smoked salmon with fresh dill, lemon, and rye crisps — '
          'a lighter opener before the heartier mains.',
      contains:
          'Smoked salmon, dill, lemon, rye crisps or bread, crème fraîche '
          'or butter, capers (optional).',
      allergens: 'Fish, gluten. May contain dairy.',
      spiceLevel: 'Not spicy',
      wikipediaUrl: 'https://en.wikipedia.org/wiki/Smoked_salmon',
      imageAsset: FoodAssets.polish('losos'),
    ),
    FoodItem(
      culture: FoodCulture.polish,
      course: FoodCourse.starter,
      name: 'Pierogi Ruskie',
      description:
          'Pan-fried dumplings filled with potato, farmer\'s cheese, and onion — '
          'one of Poland\'s most recognisable comfort foods.',
      contains:
          'Wheat dough, potato, farmer\'s cheese (twaróg), onion, butter, '
          'sour cream, salt, pepper.',
      allergens: 'Gluten, dairy, eggs.',
      spiceLevel: 'Mild',
      wikipediaUrl: 'https://en.wikipedia.org/wiki/Pierogi',
      imageAsset: FoodAssets.polish('pierogi-ruskie'),
    ),
    FoodItem(
      culture: FoodCulture.polish,
      course: FoodCourse.starter,
      name: 'Tatar Wołowy',
      description:
          'Hand-chopped raw beef tartare seasoned with capers, shallot, and egg '
          'yolk, served with toasted bread — bold and celebratory.',
      contains:
          'Raw beef, egg yolk, capers, shallot, pickled cucumber, mustard, '
          'Worcestershire sauce, toast.',
      allergens: 'Gluten, eggs, beef.',
      spiceLevel: 'Mild',
      wikipediaUrl: 'https://en.wikipedia.org/wiki/Steak_tartare',
      imageAsset: FoodAssets.polish('tatar'),
    ),
    FoodItem(
      culture: FoodCulture.polish,
      course: FoodCourse.starter,
      name: 'Śledź w Oleju',
      description:
          'Marinated herring fillets with red onion and apple — sharp, bright, '
          'and very traditional on a Polish feast table.',
      contains:
          'Herring fillets, onion, apple, sunflower or rapeseed oil, vinegar, '
          'bay leaf, peppercorns, allspice.',
      allergens: 'Fish.',
      spiceLevel: 'Mild',
      wikipediaUrl: 'https://en.wikipedia.org/wiki/Pickled_herring',
      imageAsset: FoodAssets.polish('sledz'),
    ),

    // Polish — mains
    FoodItem(
      culture: FoodCulture.polish,
      course: FoodCourse.main,
      name: 'Kotlet Schabowy',
      description:
          'Golden breaded pork cutlet with buttery mashed potatoes, pickled '
          'cucumber, and a simple pan sauce — the Sunday-dinner classic.',
      contains:
          'Pork loin, breadcrumbs, egg, flour, potato, butter, milk, '
          'pickled cucumber, pork or mushroom sauce.',
      allergens: 'Gluten, eggs, dairy, pork.',
      spiceLevel: 'Mild',
      wikipediaUrl: 'https://en.wikipedia.org/wiki/Kotlet_schabowy',
      imageAsset: FoodAssets.polish('kotlet-schabowy'),
    ),
    FoodItem(
      culture: FoodCulture.polish,
      course: FoodCourse.main,
      name: 'Rolada Wołowa',
      description:
          'Slow-braised beef roulade stuffed with bacon, gherkin, and mustard, '
          'served with red cabbage and kluski dumplings.',
      contains:
          'Beef, bacon, gherkin, mustard, onion, beef stock, red cabbage, '
          'kluski (wheat flour, egg).',
      allergens: 'Gluten, eggs, beef, pork.',
      spiceLevel: 'Mild',
      wikipediaUrl: 'https://en.wikipedia.org/wiki/Rouladen',
      imageAsset: FoodAssets.polish('rolada'),
    ),
    FoodItem(
      culture: FoodCulture.polish,
      course: FoodCourse.main,
      name: 'Kaczka Pieczona',
      description:
          'Roast duck with apple, juniper, and honey glaze, alongside potato '
          'dumplings and braised red cabbage.',
      contains:
          'Duck, apple, juniper, honey, red cabbage, potato dumplings '
          '(wheat flour, potato), onion, stock.',
      allergens: 'Gluten, eggs. Contains duck.',
      spiceLevel: 'Mild',
      wikipediaUrl: 'https://en.wikipedia.org/wiki/Roast_duck',
      imageAsset: FoodAssets.polish('kaczka'),
    ),
    FoodItem(
      culture: FoodCulture.polish,
      course: FoodCourse.main,
      name: 'Pierogi z Mięsem',
      description:
          'Hearty meat-filled dumplings topped with caramelised onion '
          'and a spoonful of sour cream.',
      contains:
          'Wheat dough, minced pork or beef, onion, butter, sour cream, '
          'salt, pepper, marjoram.',
      allergens: 'Gluten, dairy, eggs, meat (pork or beef).',
      spiceLevel: 'Mild',
      wikipediaUrl: 'https://en.wikipedia.org/wiki/Pierogi',
      imageAsset: FoodAssets.polish('pierogi-mieso'),
    ),
    FoodItem(
      culture: FoodCulture.polish,
      course: FoodCourse.main,
      name: 'Bigos',
      description:
          'Hunter\'s stew of sauerkraut, fresh cabbage, and mixed meats, '
          'simmered low and slow with prunes and bay leaf.',
      contains:
          'Sauerkraut, white cabbage, pork, sausage, bacon, onion, tomato '
          'paste, prunes, bay leaf, juniper, red wine (optional).',
      allergens: 'Pork. May contain sulphites (sauerkraut).',
      spiceLevel: 'Mild',
      wikipediaUrl: 'https://en.wikipedia.org/wiki/Bigos',
      imageAsset: FoodAssets.polish('bigos'),
    ),
    FoodItem(
      culture: FoodCulture.polish,
      course: FoodCourse.main,
      name: 'Żeberka w Miodzie',
      description:
          'Sticky honey-glazed pork ribs with roasted root vegetables — '
          'rich, celebratory, and impossible to eat politely.',
      contains:
          'Pork ribs, honey, garlic, mustard, soy sauce, root vegetables '
          '(carrot, parsnip), thyme, stock.',
      allergens: 'Pork, soy. May contain gluten (soy sauce).',
      spiceLevel: 'Mild',
      wikipediaUrl: 'https://en.wikipedia.org/wiki/Pork_ribs',
      imageAsset: FoodAssets.polish('zeberka'),
    ),

    // Polish — desserts
    FoodItem(
      culture: FoodCulture.polish,
      course: FoodCourse.dessert,
      name: 'Sernik',
      description:
          'Baked Polish cheesecake with vanilla, lemon zest, and raisins — '
          'dense, creamy, and gently sweet.',
      contains:
          'Farmer\'s cheese (twaróg), eggs, sugar, butter, vanilla, lemon '
          'zest, raisins, biscuit base (wheat).',
      allergens: 'Gluten, dairy, eggs.',
      spiceLevel: 'Not spicy',
      wikipediaUrl: 'https://en.wikipedia.org/wiki/Sernik',
      imageAsset: FoodAssets.polish('sernik'),
    ),
    FoodItem(
      culture: FoodCulture.polish,
      course: FoodCourse.dessert,
      name: 'Makowiec',
      description:
          'Poppy seed roll with honey, nuts, and citrus — a Christmas '
          'favourite that works beautifully at weddings too.',
      contains:
          'Wheat flour, poppy seeds, honey, walnuts, orange zest, yeast, '
          'butter, eggs, sugar.',
      allergens: 'Gluten, dairy, eggs, nuts.',
      spiceLevel: 'Not spicy',
      wikipediaUrl: 'https://en.wikipedia.org/wiki/Makowiec',
      imageAsset: FoodAssets.polish('makowiec'),
    ),
    FoodItem(
      culture: FoodCulture.polish,
      course: FoodCourse.dessert,
      name: 'Szarlotka',
      description:
          'Rustic Polish apple cake with cinnamon crumble topping, '
          'served warm with a dollop of cream.',
      contains:
          'Apple, wheat flour, butter, sugar, eggs, cinnamon, breadcrumbs '
          'or crumble topping, cream (optional).',
      allergens: 'Gluten, dairy, eggs.',
      spiceLevel: 'Not spicy',
      wikipediaUrl: 'https://en.wikipedia.org/wiki/Szarlotka',
      imageAsset: FoodAssets.polish('szarlotka'),
    ),
    FoodItem(
      culture: FoodCulture.polish,
      course: FoodCourse.dessert,
      name: 'Pączki',
      description:
          'Fluffy Polish doughnuts filled with rose-petal jam and dusted with sugar.',
      contains:
          'Wheat flour, yeast, eggs, butter, milk, sugar, rose jam, '
          'icing sugar, oil for frying.',
      allergens: 'Gluten, dairy, eggs.',
      spiceLevel: 'Not spicy',
      wikipediaUrl: 'https://en.wikipedia.org/wiki/P%C4%85czki',
      imageAsset: FoodAssets.polish('paczki'),
    ),
    FoodItem(
      culture: FoodCulture.polish,
      course: FoodCourse.dessert,
      name: 'Kremówka',
      description:
          'Layers of crisp puff pastry and vanilla custard — the famous '
          '"papal cream cake" from Wadowice.',
      contains:
          'Puff pastry (wheat flour, butter), milk, eggs, sugar, vanilla, '
          'cornflour, icing sugar.',
      allergens: 'Gluten, dairy, eggs.',
      spiceLevel: 'Not spicy',
      wikipediaUrl: 'https://en.wikipedia.org/wiki/Krem%C3%B3wka',
      imageAsset: FoodAssets.polish('kremowka'),
    ),
    FoodItem(
      culture: FoodCulture.polish,
      course: FoodCourse.dessert,
      name: 'Kompot z Owoców',
      description:
          'A chilled stewed-fruit compote of seasonal berries and stone fruit — '
          'light and refreshing to finish.',
      contains:
          'Mixed seasonal fruit (apple, cherry, plum, berries), sugar, water, '
          'cinnamon, cloves (optional).',
      allergens: 'None common.',
      spiceLevel: 'Not spicy',
      wikipediaUrl: 'https://en.wikipedia.org/wiki/Kompot',
      imageAsset: FoodAssets.polish('kompot'),
    ),

    // Goan — starters (snacks + salad/bread)
    FoodItem(
      culture: FoodCulture.goan,
      course: FoodCourse.starter,
      name: 'Chutney Sandwich',
      description:
          'A simple Goan party favourite — soft bread spread with fresh green '
          'chutney, often cut into neat fingers for passing around with tea.',
      contains:
          'Bread (wheat), butter or margarine, green chutney (coriander, mint, '
          'green chilli, lemon, salt).',
      allergens: 'Gluten. May contain dairy.',
      spiceLevel: 'Mild',
      wikipediaUrl: 'https://en.wikipedia.org/wiki/Chutney',
      imageAsset: FoodAssets.goan('chutney-sandwich'),
    ),
    FoodItem(
      culture: FoodCulture.goan,
      course: FoodCourse.starter,
      name: 'Forminhas',
      description:
          'Small savoury pastry tartlets — crisp cups filled with spiced mince '
          'or fish, borrowed from Portuguese tea-time tradition and beloved at '
          'Goan weddings.',
      contains:
          'Shortcrust pastry (wheat flour, butter), spiced minced meat or fish, '
          'onion, garlic, Goan spices.',
      allergens: 'Gluten, eggs, dairy. Contains meat or fish depending on batch.',
      spiceLevel: 'Mild–medium',
      wikipediaUrl: 'https://en.wikipedia.org/wiki/Goan_cuisine',
      imageAsset: FoodAssets.goan('forminhas'),
    ),
    FoodItem(
      culture: FoodCulture.goan,
      course: FoodCourse.starter,
      name: 'Beef Croquettes',
      description:
          'Golden, crumb-coated croquettes with a savoury shredded beef filling — '
          'crisp outside, soft and spiced within.',
      contains:
          'Beef, potato, onion, breadcrumbs, egg, flour, garlic, pepper, spices.',
      allergens: 'Gluten, eggs, beef.',
      spiceLevel: 'Mild',
      wikipediaUrl: 'https://en.wikipedia.org/wiki/Croquette',
      imageAsset: FoodAssets.goan('beef-croquettes'),
    ),
    FoodItem(
      culture: FoodCulture.goan,
      course: FoodCourse.starter,
      name: 'Chicken Lollipop',
      description:
          'Chicken drumettes frenched and shaped like lollipops, marinated and '
          'fried in an Indo-Chinese style until sticky and crisp.',
      contains:
          'Chicken, flour, cornflour, soy sauce, ginger, garlic, chilli, '
          'spring onion, spices.',
      allergens: 'Gluten, soy, chicken.',
      spiceLevel: 'Medium–hot',
      wikipediaUrl: 'https://en.wikipedia.org/wiki/Chicken_lollipop',
      imageAsset: FoodAssets.goan('chicken-lollipop'),
    ),
    FoodItem(
      culture: FoodCulture.goan,
      course: FoodCourse.starter,
      name: 'Prawn Rissois',
      description:
          'Crescent-shaped fried pastries with a creamy prawn filling — a '
          'Portuguese-Goan classic that appears at almost every celebration.',
      contains:
          'Prawns, flour pastry, milk, butter, onion, garlic, nutmeg, pepper.',
      allergens: 'Gluten, shellfish, dairy, eggs.',
      spiceLevel: 'Mild',
      wikipediaUrl: 'https://en.wikipedia.org/wiki/Rissole',
      imageAsset: FoodAssets.goan('prawn-rissois'),
    ),
    FoodItem(
      culture: FoodCulture.goan,
      course: FoodCourse.starter,
      name: 'Goan Salad',
      description:
          'A bright, tangy salad of fresh vegetables dressed with vinegar and '
          'mild spices — a cooling counterpoint to richer fried snacks.',
      contains:
          'Tomato, onion, cucumber, carrot, vinegar, salt, pepper, optional green chilli.',
      allergens: 'None common.',
      spiceLevel: 'Mild (optional chilli)',
      wikipediaUrl: 'https://en.wikipedia.org/wiki/Goan_cuisine',
      imageAsset: FoodAssets.goan('goan-salad'),
    ),
    FoodItem(
      culture: FoodCulture.goan,
      course: FoodCourse.starter,
      name: 'Fish Mayonnaise',
      description:
          'Flaked poached fish folded through a creamy mayonnaise dressing, '
          'served cold — a staple at Goan buffet tables.',
      contains:
          'Fish (commonly kingfish or pomfret), mayonnaise, egg, lemon, onion, '
          'pepper, salt.',
      allergens: 'Fish, eggs. May contain dairy (mayonnaise).',
      spiceLevel: 'Not spicy',
      wikipediaUrl: 'https://en.wikipedia.org/wiki/Mayonnaise',
      imageAsset: FoodAssets.goan('fish-mayonnaise'),
    ),
    FoodItem(
      culture: FoodCulture.goan,
      course: FoodCourse.starter,
      name: 'Dinner Roll',
      description:
          'Soft, fluffy white bread rolls served alongside the main courses '
          'for mopping up curries and gravies.',
      contains: 'Wheat flour, yeast, water, sugar, salt, butter or oil.',
      allergens: 'Gluten. May contain dairy.',
      spiceLevel: 'Not spicy',
      wikipediaUrl: 'https://en.wikipedia.org/wiki/Bread_roll',
      imageAsset: FoodAssets.goan('dinner-roll'),
    ),
    FoodItem(
      culture: FoodCulture.goan,
      course: FoodCourse.starter,
      name: 'Sanna',
      description:
          'Steamed rice cakes with fresh coconut — a slightly sweet, spongy '
          'Goan bread traditionally paired with sorpotel or curries.',
      contains: 'Rice, fresh coconut, yeast, sugar, salt.',
      allergens: 'None common.',
      spiceLevel: 'Not spicy',
      wikipediaUrl: 'https://en.wikipedia.org/wiki/Sanna_(food)',
      imageAsset: FoodAssets.goan('sanna'),
    ),

    // Goan — mains
    FoodItem(
      culture: FoodCulture.goan,
      course: FoodCourse.main,
      name: 'Pea Pulao',
      description:
          'Fragrant basmati rice cooked with green peas and whole spices — '
          'a lighter rice dish alongside the richer curries.',
      contains:
          'Basmati rice, peas, ghee or oil, onion, cumin, bay leaf, cardamom, '
          'cinnamon, salt.',
      allergens: 'May contain dairy (ghee).',
      spiceLevel: 'Mild',
      wikipediaUrl: 'https://en.wikipedia.org/wiki/Pilaf',
      imageAsset: FoodAssets.goan('pea-pulao'),
    ),
    FoodItem(
      culture: FoodCulture.goan,
      course: FoodCourse.main,
      name: 'Chana Masala',
      description:
          'Chickpeas simmered in a spiced tomato-onion gravy — a hearty '
          'vegetarian main that holds its own on a Goan wedding spread.',
      contains:
          'Chickpeas, tomato, onion, garlic, ginger, cumin, coriander, garam '
          'masala, chilli, oil.',
      allergens: 'None common.',
      spiceLevel: 'Medium',
      wikipediaUrl: 'https://en.wikipedia.org/wiki/Chana_masala',
      imageAsset: FoodAssets.goan('chana-masala'),
    ),
    FoodItem(
      culture: FoodCulture.goan,
      course: FoodCourse.main,
      name: 'Pork Sorpotel',
      description:
          'A rich, vinegary pork stew traditionally made with offal and simmered '
          'for days ahead of a feast — the defining dish of Goan Catholic celebrations.',
      contains:
          'Pork (including offal), vinegar, dried red chillies, garlic, ginger, '
          'cumin, cinnamon, cloves, pepper, onion.',
      allergens: 'Pork.',
      spiceLevel: 'Hot',
      wikipediaUrl: 'https://en.wikipedia.org/wiki/Sorpotel',
      imageAsset: FoodAssets.goan('pork-sorpotel'),
    ),
    FoodItem(
      culture: FoodCulture.goan,
      course: FoodCourse.main,
      name: 'Chicken Manchurian',
      description:
          'Battered fried chicken pieces tossed in a glossy Indo-Chinese sauce '
          'of soy, ginger, garlic, and chilli — crowd-pleasing and boldly flavoured.',
      contains:
          'Chicken, cornflour, soy sauce, ginger, garlic, spring onion, green '
          'chilli, ketchup, vinegar, sugar.',
      allergens: 'Gluten, soy, chicken.',
      spiceLevel: 'Medium–hot',
      wikipediaUrl: 'https://en.wikipedia.org/wiki/Chicken_Manchurian',
      imageAsset: FoodAssets.goan('chicken-manchurian'),
    ),
    FoodItem(
      culture: FoodCulture.goan,
      course: FoodCourse.main,
      name: 'Tongue Roast / Chilly',
      description:
          'Slow-cooked beef tongue roasted with spices, finished with a chilli '
          'tempering — tender, deeply savoury, and unmistakably celebratory.',
      contains:
          'Beef tongue, onion, garlic, ginger, vinegar, dried red chillies, '
          'Goan spices, oil.',
      allergens: 'Beef.',
      spiceLevel: 'Medium–hot',
      wikipediaUrl: 'https://en.wikipedia.org/wiki/Beef_tongue',
      imageAsset: FoodAssets.goan('tongue-roast-chilly'),
    ),
    FoodItem(
      culture: FoodCulture.goan,
      course: FoodCourse.main,
      name: 'Veg Chow Chow',
      description:
          'Stir-fried noodles with mixed vegetables in a mild Indo-Chinese sauce — '
          'a familiar comfort dish on long buffet tables.',
      contains:
          'Wheat or egg noodles, cabbage, carrot, capsicum, onion, soy sauce, '
          'ginger, garlic, vinegar, oil.',
      allergens: 'Gluten, soy. May contain eggs (noodles).',
      spiceLevel: 'Mild',
      wikipediaUrl: 'https://en.wikipedia.org/wiki/Chow_mein',
      imageAsset: FoodAssets.goan('veg-chow-chow'),
    ),
    FoodItem(
      culture: FoodCulture.goan,
      course: FoodCourse.main,
      name: 'Prawn Masala',
      description:
          'Prawns cooked in a thick, spiced onion-tomato masala — punchy and '
          'aromatic without the coconut base of a traditional Goan curry.',
      contains:
          'Prawns, onion, tomato, garlic, ginger, coriander, cumin, turmeric, '
          'chilli, oil.',
      allergens: 'Shellfish.',
      spiceLevel: 'Medium',
      wikipediaUrl: 'https://en.wikipedia.org/wiki/Masala',
      imageAsset: FoodAssets.goan('prawn-masala'),
    ),
    FoodItem(
      culture: FoodCulture.goan,
      course: FoodCourse.main,
      name: 'Mutton Xacuti',
      description:
          'Mutton braised in a complex roasted-spice coconut curry with poppy seed '
          'and Kashmiri chilli — one of Goan cuisine\'s most celebrated dishes.',
      contains:
          'Mutton, coconut, dried red chillies, coriander seed, cumin, poppy seed, '
          'star anise, cloves, onion, garlic, turmeric, oil.',
      allergens: 'None common. Contains mutton (lamb/goat).',
      spiceLevel: 'Medium–hot',
      wikipediaUrl: 'https://en.wikipedia.org/wiki/Xacuti',
      imageAsset: FoodAssets.goan('mutton-xacuti'),
    ),
    FoodItem(
      culture: FoodCulture.goan,
      course: FoodCourse.main,
      name: 'Prawn Curry & Rice',
      description:
          'Shell-on prawns in a coconut-based curry gravy, served with steamed '
          'basmati rice — the quintessential Goan coastal pairing.',
      contains:
          'Prawns, coconut, dried red chillies, coriander, cumin, turmeric, '
          'tamarind or kokum, onion, garlic, basmati rice.',
      allergens: 'Shellfish.',
      spiceLevel: 'Medium',
      wikipediaUrl: 'https://en.wikipedia.org/wiki/Prawn_curry',
      imageAsset: FoodAssets.goan('prawn-curry-rice'),
    ),

    // Goan — desserts
    FoodItem(
      culture: FoodCulture.goan,
      course: FoodCourse.dessert,
      name: 'Fruit Custard',
      description:
          'Chilled vanilla custard folded through diced seasonal fruit — light, '
          'familiar, and a gentle finish after a long meal.',
      contains:
          'Milk, sugar, custard powder (cornflour, vanilla), mixed fruit '
          '(banana, apple, grapes, pomegranate).',
      allergens: 'Dairy.',
      spiceLevel: 'Not spicy',
      wikipediaUrl: 'https://en.wikipedia.org/wiki/Custard',
      imageAsset: FoodAssets.goan('fruit-custard'),
    ),
    FoodItem(
      culture: FoodCulture.goan,
      course: FoodCourse.dessert,
      name: 'Jelly',
      description:
          'Bright, wobbly fruit jelly — a simple, nostalgic sweet that rounds '
          'off a Goan wedding buffet.',
      contains: 'Gelatin, sugar, fruit flavouring, food colouring, water.',
      allergens: 'None common.',
      spiceLevel: 'Not spicy',
      wikipediaUrl: 'https://en.wikipedia.org/wiki/Gelatin_dessert',
      imageAsset: FoodAssets.goan('jelly'),
    ),
    FoodItem(
      culture: FoodCulture.goan,
      course: FoodCourse.dessert,
      name: 'Crème Caramel',
      description:
          'Silky baked custard with a golden caramel top — a Portuguese legacy '
          'that remains a staple at Goan celebrations.',
      contains: 'Milk, eggs, sugar, vanilla.',
      allergens: 'Dairy, eggs.',
      spiceLevel: 'Not spicy',
      wikipediaUrl: 'https://en.wikipedia.org/wiki/Cr%C3%A8me_caramel',
      imageAsset: FoodAssets.goan('creme-caramel'),
    ),
  ];

  static List<FoodItem> forCulture(FoodCulture culture) =>
      items.where((item) => item.culture == culture).toList();

  static List<FoodItem> forCultureAndCourse(
    FoodCulture culture,
    FoodCourse course,
  ) =>
      items
          .where((item) => item.culture == culture && item.course == course)
          .toList();
}
