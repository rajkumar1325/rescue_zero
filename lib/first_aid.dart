// lib/first_aid.dart --> contains remedies in english or hindi/hinglish
final List<Map<String, String>> firstAidList = [ // List of map of data(key-string and value-string)


  // Colds, Coughs & Fever
  {
    'en_q': 'Severe Cough & Sore Throat?',
    'en_a':
        'Crush Ginger (Adrak) and mix with 1 spoon of Honey (Shahad). Swallow slowly. Gargle with warm Salt water 3 times a day.',
    'hi_q': 'Tej Khansi aur Gale mein dard?',
    'hi_a':
        'Adrak ko pees kar ek chammach Shahad ke saath dheere-dheere khayein. Din mein 3 baar gungune namak paani se kulla karein.',
  },
  {
    'en_q': 'High Fever (Emergency cooling)?',
    'en_a':
        'Place cold, wet cloth strips on the forehead, wrists, and back of the neck. Boil Tulsi leaves and Giloy, let it cool, and drink.',
    'hi_q': 'Tej Bukhar (Jaldi kam karne ke liye)?',
    'hi_a':
        'Mathe, kalai aur gardan ke peeche thande, geele kapde ki patti rakhein. Tulsi aur Giloy ubaal kar thanda karke piyein.',
  },
  {
    'en_q': 'Blocked Nose / Sinus Pain?',
    'en_a':
        'Take steam from boiling water mixed with a few drops of Eucalyptus oil or a pinch of Ajwain (Carom seeds).',
    'hi_q': 'Band Naak ya Sinus ka dard?',
    'hi_a':
        'Ubalte paani mein thoda Ajwain ya Nilgiri (Eucalyptus) tel daal kar bhaap (steam) lein.',
  },
  {
    'en_q': 'Dry Cough that won’t stop?',
    'en_a':
        'Keep a Clove (Laung) or a small piece of Mulethi (Licorice) in your mouth and slowly suck on its juices.',
    'hi_q': 'Sookhi khansi jo ruk nahi rahi?',
    'hi_a':
        'Ek Laung ya thodi si Mulethi muh mein rakh kar dheere-dheere choostein rahein.',
  },




  // Stomach & Digestion
  {
    'en_q': 'Severe Gas / Acidity Pain?',
    'en_a':
        'Chew 1/2 spoon of Ajwain with a pinch of Black Salt (Kala Namak) and drink warm water. Cold milk also instantly neutralizes acid.',
    'hi_q': 'Tej Gas ya Acidity ka dard?',
    'hi_a':
        'Aadha chammach Ajwain aur thoda Kala Namak chaba kar gunguna paani piyein. Thanda doodh bhi acid ko turant khatam karta hai.',
  },
  {
    'en_q': 'Heavy Stomach / Indigestion?',
    'en_a':
        'Mix a tiny pinch of Asafoetida (Hing) in half a glass of warm water and drink it.',
    'hi_q': 'Bhari pait / Khaana hazam nahi ho raha?',
    'hi_a': 'Aadhe glass gungune paani mein ek chutki Hing milakar piyein.',
  },
  {
    'en_q': 'Loose Motions / Diarrhea?',
    'en_a':
        'Eat plain Curd (Dahi) mixed with roasted Cumin (Jeera) powder. Drink ORS (1 liter water + 6 spoons sugar + 1/2 spoon salt).',
    'hi_q': 'Dast (Loose motions)?',
    'hi_a':
        'Saada Dahi mein bhuna hua Jeera milakar khayein. ORS ka ghol piyein (1 liter paani + 6 chammach cheeni + 1/2 chammach namak).',
  },
  {
    'en_q': 'Severe Constipation?',
    'en_a':
        'Drink a glass of warm milk with 1 spoon of pure Ghee before sleeping.',
    'hi_q': 'Tej Kabz (Constipation)?',
    'hi_a':
        'Sone se pehle ek glass gungune doodh mein ek chammach asli Ghee milakar piyein.',
  },
  {
    'en_q': 'Nausea / Vomiting feeling?',
    'en_a':
        'Smell a cut Lemon. Slowly sip warm water mixed with Lemon juice and crushed Mint (Pudina) leaves.',
    'hi_q': 'Ulti (Vomiting) jaisa lagna?',
    'hi_a':
        'Katta hua Nimbu sunnghe. Nimbu aur peese hue Pudine ka gunguna paani dheere-dheere piyein.',
  },
  {
    'en_q': 'Food Poisoning (Initial step)?',
    'en_a':
        'Drink lots of electrolyte water. 1 spoon of Apple Cider Vinegar in warm water can help kill stomach bacteria.',
    'hi_q': 'Food Poisoning (Shuruati ilaaj)?',
    'hi_a':
        'Bahut saara ORS paani piyein. Gungune paani mein 1 chammach Apple Cider Vinegar milakar peene se bacteria marte hain.',
  },





  // Wounds, Cuts & Bleeding
  {
    'en_q': 'Bleeding from a Deep Cut?',
    'en_a':
        'Press a clean cloth hard on the cut. Apply Turmeric (Haldi) powder directly—it clots blood fast and prevents infection. Elevate the wound.',
    'hi_q': 'Gehre cut se khoon aana?',
    'hi_a':
        'Cut par saaf kapda zor se dabayein. Turant Haldi powder lagayein—yeh khoon rokti hai aur infection se bachati hai. Chot ko upar utha kar rakhein.',
  },
  {
    'en_q': 'Minor shaving cut?',
    'en_a':
        'Rub a wet Alum block (Phitkari) directly on the cut to stop bleeding instantly.',
    'hi_q': 'Shaving karte hue minor cut?',
    'hi_a':
        'Geeli Phitkari (Alum) ko cut par ragdein, khoon turant ruk jayega.',
  },
  {
    'en_q': 'Splinter (Thorn/Wood) in skin?',
    'en_a':
        'Make a thick paste of Baking Soda and water. Apply it over the splinter and bandage it. The skin will swell slightly and push it out.',
    'hi_q': 'Khaal mein Kaanta (Splinter) fas jaye?',
    'hi_a':
        'Baking Soda aur paani ka gaadha paste banakar kaante par lagayein aur patti baandh lein. Khaal phool kar kaante ko bahar nikal degi.',
  },
  {
    'en_q': 'Nosebleed?',
    'en_a':
        'Sit straight and tilt your head SLIGHTLY FORWARD (not backward). Pinch the soft part of your nose for 10 minutes. Put ice on the bridge of the nose.',
    'hi_q': 'Naak se khoon (Nakseer) aana?',
    'hi_a':
        'Seedhe baithein aur sar thoda AAGE jhukayein (peeche nahi). Naak ko 10 minute tak daba kar rakhein. Naak ke upar barf rakhein.',
  },
  {
    'en_q': 'Blisters (Shoe bites)?',
    'en_a':
        'Do NOT pop them. Apply Petroleum jelly or plain Coconut oil to reduce friction.',
    'hi_q': 'Joote katne se Chhale (Blisters)?',
    'hi_a':
        'Unhein fodein nahi. Ragar kam karne ke liye Petroleum jelly ya saaf Nariyal tel lagayein.',
  },




  // Burns & Heat
  {
    'en_q': 'Minor Skin Burn (Hot pan/oil)?',
    'en_a':
        'Keep under COOL running water for 15 mins. NEVER apply ice! Afterwards, apply pure Honey or fresh Aloe Vera gel.',
    'hi_q': 'Garam bartan ya tel se hath jalna?',
    'hi_a':
        '15 minute tak THANDE chalte paani ke neeche rakhein. Barf KABHI mat lagayein! Uske baad Shahad ya Aloe Vera gel lagayein.',
  },
  {
    'en_q': 'Sunburn?',
    'en_a':
        'Apply cold Yogurt (Dahi) or pureed Cucumber (Kheera) to the skin to pull out the heat.',
    'hi_q': 'Dhoop se skin jal jana (Sunburn)?',
    'hi_a':
        'Thanda Dahi ya pisa hua Kheera (Cucumber) skin par lagayein taaki garmi nikal jaye.',
  },
  {
    'en_q': 'Heat Stroke (Loo lagna)?',
    'en_a':
        'Move to shade. Drink Aam Panna (Raw Mango drink) or Onion juice. Wipe the body with a cold, wet towel.',
    'hi_q': 'Loo lagna (Heat Stroke)?',
    'hi_a':
        'Chhaav mein aayein. Aam Panna ya Pyaz ka ras piyein. Thande geele toliye se poori body ko pochein.',
  },
  {
    'en_q': 'Burnt tongue (from hot food)?',
    'en_a':
        'Keep a pinch of Sugar or a spoonful of Honey on the tongue and let it dissolve slowly.',
    'hi_q': 'Garam khane se Jeebh (Tongue) jal jana?',
    'hi_a':
        'Jeebh par thodi Cheeni ya ek chammach Shahad rakhein aur dheere-dheere ghulne dein.',
  },




  // Pains & Aches
  {
    'en_q': 'Sudden Severe Toothache?',
    'en_a':
        'Bite down on a Clove (Laung) near the hurting tooth, or apply Clove oil. Gargle with warm salt water to reduce swelling.',
    'hi_q': 'Achanak Tej Dant Dard?',
    'hi_a':
        'Dard wale dant ke paas ek Laung dabayein, ya Laung ka tel lagayein. Sujan kam karne ke liye namak paani ka kulla karein.',
  },
  {
    'en_q': 'Earache?',
    'en_a':
        'Heat a crushed Garlic (Lehsun) clove in a little Mustard Oil. Let it cool until just slightly warm, and put 2 drops in the ear.',
    'hi_q': 'Kaan ka dard?',
    'hi_a':
        'Sarso ke tel mein ek Lehsun pees kar garam karein. Jab thoda gunguna reh jaye, toh 2 boond kaan mein dalein.',
  },
  {
    'en_q': 'Headache / Migraine?',
    'en_a':
        'Drink strong Adrak (Ginger) tea. Apply Peppermint oil or a paste of Sandalwood (Chandan) on the forehead.',
    'hi_q': 'Sir Dard / Migraine?',
    'hi_a':
        'Kadak Adrak ki chai piyein. Mathe par Peppermint tel ya Chandan ka lep lagayein.',
  },
  {
    'en_q': 'Muscle Cramp (Nas chadhna)?',
    'en_a':
        'Stretch the muscle gently. Apply a hot water bag. Drink a glass of water with a pinch of salt.',
    'hi_q': 'Nas chadh jana (Muscle Cramp)?',
    'hi_a':
        'Nas ko halke se kheechein (stretch karein). Garam paani ki bottle se sek karein. Ek glass paani mein namak dalkar piyein.',
  },
  {
    'en_q': 'Sprain / Swelling (Moch)?',
    'en_a':
        'Apply an Ice pack for the first 24 hours. Make a warm paste of Haldi (Turmeric) and Chuna (Edible lime) and apply to the joint.',
    'hi_q': 'Moch aur Sujan (Sprain)?',
    'hi_a':
        'Pehle 24 ghante Barf lagayein. Phir Haldi aur khaane wale Chune ka garam lep lagayein.',
  },
  {
    'en_q': 'Period / Menstrual Cramps?',
    'en_a':
        'Use a hot water bag on the lower belly. Drink warm Ajwain water or Chamomile tea.',
    'hi_q': 'Period ka Tej Dard?',
    'hi_a':
        'Pait ke neeche garam paani ki bottle rakhein. Gunguna Ajwain paani piyein.',
  },
  {
    'en_q': 'Joint Pain / Arthritis acting up?',
    'en_a': 'Massage with warm Mustard oil infused with Garlic and Ajwain.',
    'hi_q': 'Jodo ka dard (Joint pain)?',
    'hi_a':
        'Sarso ke tel mein Lehsun aur Ajwain jalakar, us gungune tel se malish karein.',
  },





  // Bites, Stings & Allergies
  {
    'en_q': 'Bee / Wasp Sting?',
    'en_a':
        'Remove the stinger by scraping it with a credit card. Apply a thick paste of Baking Soda and water to neutralize the acid.',
    'hi_q': 'Madhumakkhi ya Tatiya ka katna?',
    'hi_a':
        'Pehle dank ko nikaalein. Phir zehar ko kaatne ke liye Baking Soda aur paani ka gaadha paste lagayein.',
  },
  {
    'en_q': 'Mosquito or Ant Bites?',
    'en_a':
        'Rub a slice of Lemon or apply Aloe Vera gel to stop the severe itching.',
    'hi_q': 'Machhar ya Cheenti ka katna?',
    'hi_a':
        'Khujli rokne ke liye Nimbu ka tukda ragdein ya Aloe Vera gel lagayein.',
  },
  {
    'en_q': 'Dog Bite (Immediate first aid)?',
    'en_a':
        'Wash the wound heavily with soap and running water for at least 15 minutes to flush out rabies virus. Go to a hospital immediately for injections.',
    'hi_q': 'Kutte ka katna (Shuruati ilaaj)?',
    'hi_a':
        'Ghav ko sabun aur chalte paani se lagatar 15 minute tak dhoye taaki Rabies ka virus nikal jaye. Turant hospital jaakar injection lagwayein.',
  },
  {
    'en_q': 'Snake Bite (First steps)?',
    'en_a':
        'Keep the person completely still. Keep the bitten area BELOW the heart. DO NOT cut the wound or suck the venom. Rush to the hospital.',
    'hi_q': 'Saanp ka katna?',
    'hi_a':
        'MareeZ ko bilkul hilne na dein. Kate hue hisse ko dil (heart) se NEECHE rakhein. Zehar choosne ki koshish na karein. Turant hospital bhagein.',
  },
  {
    'en_q': 'Dust Allergy / Sneezing fit?',
    'en_a':
        'Drink a cup of warm water with half a spoon of Turmeric and Black Pepper (Kaali Mirch).',
    'hi_q': 'Dhool se Allergy / Lagatar chheenk aana?',
    'hi_a':
        'Gungune paani mein aadhi chammach Haldi aur Kaali Mirch daal kar piyein.',
  },
  {
    'en_q': 'Plant Rash / Poison Ivy?',
    'en_a':
        'Wash with dish soap immediately to remove the plant oils. Apply Multani Mitti (Fuller\'s Earth) to dry the rash.',
    'hi_q': 'Khujli wale paudhe se Rash?',
    'hi_a':
        'Turant sabun se dhoye taaki paudhe ka tel nikal jaye. Rash par Multani Mitti lagayein.',
  },





  // Eyes, Ears & Mouth
  {
    'en_q': 'Dust or Insect in the Eye?',
    'en_a':
        'DO NOT RUB! Splash clean, cold water repeatedly. If it doesn’t come out, fill a bowl with water, dip your open eye in it, and blink fast.',
    'hi_q': 'Aankh mein kachra ya keeda jana?',
    'hi_a':
        'Aankh ko RAGDE NAHI! Thande paani ke chheente maarein. Ya ek katori mein paani bharkar usme aankh khol kar jaldi-jaldi jhapkayein (blink karein).',
  },
  {
    'en_q': 'Eye redness / Strain (Computer glare)?',
    'en_a':
        'Place cold Cucumber slices or cotton pads soaked in Rose Water (Gulab Jal) over closed eyes for 10 mins.',
    'hi_q': 'Aankhein laal hona / Screen se thakan?',
    'hi_a':
        'Band aankhon par thande Kheere ke tukde ya Gulab Jal mein bheege cotton pads 10 minute tak rakhein.',
  },
  {
    'en_q': 'Mouth Ulcers (Chhale)?',
    'en_a':
        'Apply pure Honey or Coconut oil directly on the ulcer. Chew on fresh Tulsi leaves.',
    'hi_q': 'Muh mein Chhale (Ulcers)?',
    'hi_a':
        'Chhalo par Shahad (Honey) ya Nariyal ka tel lagayein. Hari Tulsi ki pattiya chabayein.',
  },
  {
    'en_q': 'Water stuck in Ear?',
    'en_a':
        'Tilt your head to the side and jump lightly on one foot. Create a vacuum by pressing the palm of your hand against the ear and releasing quickly.',
    'hi_q': 'Kaan mein paani chala jana?',
    'hi_a':
        'Sar ko tedha karke ek pair par halke se koodein. Hatheli se kaan ko dabakar turant chhodein taaki vacuum ban kar paani nikal jaye.',
  },
  {
    'en_q': 'Chapped / Bleeding Lips?',
    'en_a':
        'Apply a drop of Mustard oil in your belly button (Navel) at night. Apply fresh Malai (Milk cream) directly on lips.',
    'hi_q': 'Honth phatna ya khoon aana?',
    'hi_a':
        'Raat ko Naabhi (Belly button) mein Sarso ka tel lagayein. Hontho par taazi Malai lagayein.',
  },
  {
    'en_q': 'Bad Breath?',
    'en_a':
        'Chew on Fennel seeds (Saunf), a Clove (Laung), or a piece of Cardamom (Elaichi).',
    'hi_q': 'Muh se badboo aana?',
    'hi_a': 'Saunf, Laung, ya choti Elaichi chabayein.',
  },





  // Emergency Medical States
  {
    'en_q': 'Fainting / Dizziness?',
    'en_a':
        'Lay the person flat on their back and elevate their legs using a bag or pillow. Once awake, give them ORS or Sugar-Salt water.',
    'hi_q': 'Behosh hona ya Chakkar aana?',
    'hi_a':
        'MareeZ ko seedha lita dein aur pairo ke neeche takiya lagakar unhe upar uthayein. Hosh aane par Nimbu-Cheeni-Namak ka paani pilayein.',
  },
  {
    'en_q': 'Sudden mild Low Blood Pressure?',
    'en_a':
        'Drink a glass of water with a full spoon of salt and some lemon immediately.',
    'hi_q': 'Achanak BP Low hona?',
    'hi_a':
        'Turant ek glass paani mein ek chammach namak aur nimbu daal kar pilayein.',
  },
  {
    'en_q': 'Sudden mild High Blood Pressure?',
    'en_a':
        'Sit down, close your eyes, and take slow, deep breaths. Eat a small piece of dark chocolate or raw garlic.',
    'hi_q': 'Achanak BP High hona?',
    'hi_a':
        'Baith jayein, aankhein band karein aur dheere-dheere gehri saans lein. Kaccha lehsun ya dark chocolate khayein.',
  },
  {
    'en_q': 'Panic Attack / Hyperventilating?',
    'en_a':
        'Use the 4-7-8 breathing rule: Breathe in for 4 seconds, hold for 7, exhale slowly for 8. Sip ice-cold water.',
    'hi_q': 'Ghabrahat / Panic Attack?',
    'hi_a':
        'Ginti karke saans lein: 4 second saans kheenche, 7 second rokein, 8 second mein dheere se bahar nikaalein. Thanda paani ghoont-ghoont piyein.',
  },
  {
    'en_q': 'Mild Asthma Wheezing (No inhaler)?',
    'en_a':
        'Sit upright. Drink a cup of hot, strong Black Coffee—the caffeine opens airways. Take Eucalyptus steam.',
    'hi_q': 'Asthma ki saans phoolna (Inhaler na ho)?',
    'hi_a':
        'Seedhe baithein. Garam aur strong Black Coffee piyein—caffeine saans ki nali kholti hai. Nilgiri tel ki bhaap lein.',
  },
  {
    'en_q': 'Choking (Can still cough)?',
    'en_a':
        'Encourage them to cough as hard as possible. DO NOT give water. Hit them firmly between the shoulder blades 5 times.',
    'hi_q': 'Gale mein khana fasna (Choking)?',
    'hi_a':
        'Unhe zor se khansne (cough) ko kahein. Paani BILKUL NA dein. Kandho ke beech peeth par 5 baar thap-thapayein.',
  },
  {
    'en_q': 'Swallowed a coin / small plastic?',
    'en_a':
        'If they can breathe fine, take them to the hospital for an X-Ray. DO NOT force them to vomit—it can damage the throat.',
    'hi_q': 'Sikka ya plastic nigal lena?',
    'hi_a':
        'Agar saans theek chal rahi hai, toh turant X-ray ke liye hospital le jayein. Ulti (Vomit) karwane ki koshish bilkul NA karein.',
  },





  // Miscellaneous Home Issues
  {
    'en_q': 'Continuous Hiccups?',
    'en_a':
        'Swallow a spoonful of dry sugar. Or, drink a glass of water while bending forward from the waist.',
    'hi_q': 'Lagatar Hichki (Hiccups) aana?',
    'hi_a':
        'Ek chammach sookhi cheeni nigal lein. Ya aage ki taraf jhuk kar ek glass paani piyein.',
  },
  {
    'en_q': 'Hangover / Severe Morning Nausea?',
    'en_a':
        'Eat a Banana (high potassium) and drink lots of Lemon water (Nimbu Paani) with a pinch of black salt.',
    'hi_q': 'Nasha utarne ke baad (Hangover)?',
    'hi_a':
        'Ek Kela (Banana) khayein aur Kala namak dalkar bahut saara Nimbu Paani piyein.',
  },
  {
    'en_q': 'Insomnia / Can’t sleep?',
    'en_a':
        'Drink a cup of warm milk with a tiny pinch of Nutmeg (Jaiphal) powder 30 minutes before bed.',
    'hi_q': 'Neend na aana (Insomnia)?',
    'hi_a':
        'Sone se 30 minute pehle gungune doodh mein ek chutki Jaiphal powder dalkar piyein.',
  },
  {
    'en_q': 'Ringworm / Fungal skin infection?',
    'en_a':
        'Crush raw Garlic into a paste and apply it to the ringworm, or apply Neem oil. Wash hands thoroughly.',
    'hi_q': 'Daad (Ringworm) / Fungal infection?',
    'hi_a':
        'Kacche Lehsun ka paste banakar lagayein, ya Neem ka tel lagayein. Uske baad haath acche se dhoye.',
  },
  {
    'en_q': 'Bruise (Neel padna) from hitting a table?',
    'en_a':
        'Apply an ice pack immediately for 15 mins to stop blood pooling. The next day, apply a warm compress to heal it.',
    'hi_q': 'Chot lagne se Neel padna (Bruise)?',
    'hi_a':
        'Khoon jamne se rokne ke liye turant 15 minute tak Barf lagayein. Agle din se gunguna sek (warm compress) karein.',
  },
];
