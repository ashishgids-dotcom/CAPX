/// Supported languages for first-launch selection.
enum AppLanguage { english, hindi, bhojpuri, marathi, bengali, tamil, telugu }

extension AppLanguageX on AppLanguage {
  String get code {
    switch (this) {
      case AppLanguage.english:
        return 'en';
      case AppLanguage.hindi:
        return 'hi';
      case AppLanguage.bhojpuri:
        return 'bho';
      case AppLanguage.marathi:
        return 'mr';
      case AppLanguage.bengali:
        return 'bn';
      case AppLanguage.tamil:
        return 'ta';
      case AppLanguage.telugu:
        return 'te';
    }
  }

  String get nativeName {
    switch (this) {
      case AppLanguage.english:
        return 'English';
      case AppLanguage.hindi:
        return 'हिन्दी';
      case AppLanguage.bhojpuri:
        return 'भोजपुरी';
      case AppLanguage.marathi:
        return 'मराठी';
      case AppLanguage.bengali:
        return 'বাংলা';
      case AppLanguage.tamil:
        return 'தமிழ்';
      case AppLanguage.telugu:
        return 'తెలుగు';
    }
  }

  static AppLanguage fromCode(String code) {
    return AppLanguage.values.firstWhere(
      (l) => l.code == code,
      orElse: () => AppLanguage.english,
    );
  }
}

/// -----------------------------------------------------------------------
/// GLOBAL LEGAL DISCLAIMER — now filled in for all 7 languages.
/// -----------------------------------------------------------------------
/// Shown as (a) the persistent footer marquee on the dashboard, (b) a
/// full-screen mandatory acknowledgement gate before Module A unlocks, and
/// (c) inline again inside Module A's output screen next to any
/// return/growth figures.
///
/// !! STILL GET A REAL LEGAL REVIEW BEFORE PUBLIC LAUNCH !! These are
/// careful translations of the same core legal meaning, done directly —
/// they are NOT a substitute for a lawyer confirming the final wording is
/// legally sufficient in each language/jurisdiction.
class AppStrings {
  static const String kGlobalDisclaimerEn =
      'This application is an algorithmic, rule-based EDUCATIONAL tool only. '
      'We are NOT a SEBI-registered Investment Adviser and do NOT provide '
      'licensed, personalized investment advisory, legal, GST, or income-tax '
      'filing services. All allocations, scores, and figures shown are '
      'generic illustrative examples — not individual financial, legal, or '
      'tax advice, and not a prediction or guarantee of future returns. Any '
      'investment decision you make is entirely at your own risk. Please '
      'consult a SEBI-registered Investment Adviser, a chartered accountant, '
      'or a licensed professional before making any financial, legal, or '
      'tax decision.';

  static const String kGlobalDisclaimerHi =
      'यह ऐप केवल एक एल्गोरिद्म-आधारित, नियम-आधारित शैक्षणिक (Educational) टूल है। '
      'हम SEBI-पंजीकृत निवेश सलाहकार (Investment Adviser) नहीं हैं और न ही कोई '
      'लाइसेंस्ड व्यक्तिगत निवेश सलाह, कानूनी, GST या आयकर फाइलिंग सेवा प्रदान करते हैं। '
      'दिखाए गए सभी आवंटन (allocation), स्कोर और आंकड़े केवल सामान्य उदाहरण हैं — '
      'ये व्यक्तिगत वित्तीय, कानूनी या कर सलाह नहीं हैं, और न ही भविष्य के रिटर्न की कोई '
      'भविष्यवाणी या गारंटी हैं। आप जो भी निवेश निर्णय लें, वह पूरी तरह से आपके अपने जोखिम '
      '(risk) पर होगा। कोई भी वित्तीय, कानूनी या कर संबंधी निर्णय लेने से पहले कृपया किसी '
      'SEBI-पंजीकृत निवेश सलाहकार, चार्टर्ड अकाउंटेंट या लाइसेंस्ड पेशेवर से सलाह लें।';

  static const String kGlobalDisclaimerBho =
      'ई ऐप खाली एगो एल्गोरिद्म-आधारित, नियम-आधारित शैक्षणिक (Educational) टूल बा। '
      'हमनी SEBI-पंजीकृत निवेश सलाहकार ना हईं आ ना कवनो लाइसेंस्ड व्यक्तिगत निवेश सलाह, '
      'कानूनी, GST भा आयकर फाइलिंग सेवा देनी। एह में देखावल गइल सभ आवंटन, स्कोर आ आंकड़ा '
      'खाली सामान्य उदाहरण बा — ई कवनो व्यक्तिगत वित्तीय, कानूनी भा कर सलाह ना ह, आ ना '
      'भविष्य के रिटर्न के कवनो भविष्यवाणी भा गारंटी ह। रउआ जवन भी निवेश के निर्णय लेब, ऊ '
      'पूरा तरह से रउआ अपना जोखिम (risk) पर होई। कवनो वित्तीय, कानूनी भा कर संबंधी निर्णय '
      'लेवे से पहिले कृपया कवनो SEBI-पंजीकृत निवेश सलाहकार, चार्टर्ड अकाउंटेंट भा लाइसेंस्ड '
      'पेशेवर से सलाह लीं।';

  static const String kGlobalDisclaimerMr =
      'हे अ‍ॅप केवळ एक अल्गोरिदम-आधारित, नियम-आधारित शैक्षणिक (Educational) साधन आहे. '
      'आम्ही SEBI-नोंदणीकृत गुंतवणूक सल्लागार नाही आणि कोणतीही परवानाधारक वैयक्तिक '
      'गुंतवणूक सल्ला, कायदेशीर, GST किंवा आयकर फायलिंग सेवा देत नाही. दाखवलेले सर्व '
      'वाटप (allocation), स्कोअर आणि आकडे केवळ सर्वसाधारण उदाहरणे आहेत — ही वैयक्तिक '
      'आर्थिक, कायदेशीर किंवा कर सल्ला नाही, आणि भविष्यातील परताव्याचा अंदाज किंवा हमी '
      'देखील नाही. तुम्ही घेतलेला कोणताही गुंतवणुकीचा निर्णय संपूर्णपणे तुमच्या स्वतःच्या '
      'जोखमीवर (risk) असेल. कोणताही आर्थिक, कायदेशीर किंवा कर संबंधित निर्णय घेण्यापूर्वी '
      'कृपया SEBI-नोंदणीकृत गुंतवणूक सल्लागार, चार्टर्ड अकाउंटंट किंवा परवानाधारक '
      'व्यावसायिकाचा सल्ला घ्या.';

  static const String kGlobalDisclaimerBn =
      'এই অ্যাপটি শুধুমাত্র একটি অ্যালগরিদম-ভিত্তিক, নিয়ম-ভিত্তিক শিক্ষামূলক (Educational) '
      'টুল। আমরা SEBI-নিবন্ধিত বিনিয়োগ পরামর্শদাতা নই এবং কোনো লাইসেন্সপ্রাপ্ত ব্যক্তিগত '
      'বিনিয়োগ পরামর্শ, আইনি, GST বা আয়কর ফাইলিং পরিষেবা প্রদান করি না। প্রদর্শিত সমস্ত '
      'বণ্টন (allocation), স্কোর এবং পরিসংখ্যান কেবল সাধারণ উদাহরণ — এগুলি ব্যক্তিগত '
      'আর্থিক, আইনি বা কর পরামর্শ নয়, এবং ভবিষ্যতের রিটার্নের কোনো পূর্বাভাস বা গ্যারান্টিও '
      'নয়। আপনি যে কোনো বিনিয়োগ সিদ্ধান্ত নেন তা সম্পূর্ণভাবে আপনার নিজের ঝুঁকিতে '
      '(risk) হবে। কোনো আর্থিক, আইনি বা কর সংক্রান্ত সিদ্ধান্ত নেওয়ার আগে অনুগ্রহ করে একজন '
      'SEBI-নিবন্ধিত বিনিয়োগ পরামর্শদাতা, চার্টার্ড অ্যাকাউন্ট্যান্ট বা লাইসেন্সপ্রাপ্ত '
      'পেশাদারের পরামর্শ নিন।';

  static const String kGlobalDisclaimerTa =
      'இந்த ஆப் ஒரு அல்காரிதம் அடிப்படையிலான, விதி அடிப்படையிலான கல்வி '
      '(Educational) கருவி மட்டுமே. நாங்கள் SEBI-பதிவு செய்யப்பட்ட முதலீட்டு ஆலோசகர் '
      'அல்ல, மேலும் உரிமம் பெற்ற தனிநபர் முதலீட்டு ஆலோசனை, சட்ட, GST அல்லது வருமான '
      'வரி தாக்கல் சேவைகளை வழங்குவதில்லை. காட்டப்படும் அனைத்து ஒதுக்கீடுகள் '
      '(allocation), மதிப்பெண்கள் மற்றும் புள்ளிவிவரங்கள் பொதுவான உதாரண '
      'விளக்கங்கள் மட்டுமே — இவை தனிநபர் நிதி, சட்ட அல்லது வரி ஆலோசனை அல்ல, '
      'மேலும் எதிர்கால வருமானத்தின் கணிப்பு அல்லது உத்தரவாதமும் அல்ல. நீங்கள் '
      'எடுக்கும் எந்த முதலீட்டு முடிவும் முழுவதுமாக உங்கள் சொந்த ஆபத்தில் '
      '(risk) இருக்கும். எந்தவொரு நிதி, சட்ட அல்லது வரி தொடர்பான முடிவை '
      'எடுப்பதற்கு முன் தயவுசெய்து SEBI-பதிவு செய்யப்பட்ட முதலீட்டு ஆலோசகர், '
      'சார்ட்டர்டு அக்கவுண்டன்ட் அல்லது உரிமம் பெற்ற நிபுணரை அணுகவும்.';

  static const String kGlobalDisclaimerTe =
      'ఈ యాప్ కేవలం ఒక అల్గారిథమ్ ఆధారిత, నియమ ఆధారిత విద్యాపరమైన (Educational) '
      'సాధనం మాత్రమే. మేము SEBI-నమోదిత పెట్టుబడి సలహాదారు కాదు, మరియు లైసెన్స్ '
      'పొందిన వ్యక్తిగత పెట్టుబడి సలహా, న్యాయపరమైన, GST లేదా ఆదాయపు పన్ను ఫైలింగ్ '
      'సేవలను అందించము. చూపించిన అన్ని కేటాయింపులు (allocation), స్కోర్‌లు మరియు '
      'గణాంకాలు సాధారణ ఉదాహరణలు మాత్రమే — ఇవి వ్యక్తిగత ఆర్థిక, న్యాయపరమైన లేదా '
      'పన్ను సలహా కాదు, మరియు భవిష్యత్ రాబడుల అంచనా లేదా హామీ కూడా కాదు. మీరు తీసుకునే '
      'ఏ పెట్టుబడి నిర్ణయమైనా పూర్తిగా మీ స్వంత రిస్క్ (risk) పైనే ఉంటుంది. ఏదైనా ఆర్థిక, '
      'న్యాయపరమైన లేదా పన్ను సంబంధిత నిర్ణయం తీసుకునే ముందు దయచేసి SEBI-నమోదిత '
      'పెట్టుబడి సలహాదారు, చార్టర్డ్ అకౌంటెంట్ లేదా లైసెన్స్ పొందిన నిపుణుడిని సంప్రదించండి.';

  static String globalDisclaimer(AppLanguage lang) {
    switch (lang) {
      case AppLanguage.english:
        return kGlobalDisclaimerEn;
      case AppLanguage.hindi:
        return kGlobalDisclaimerHi;
      case AppLanguage.bhojpuri:
        return kGlobalDisclaimerBho;
      case AppLanguage.marathi:
        return kGlobalDisclaimerMr;
      case AppLanguage.bengali:
        return kGlobalDisclaimerBn;
      case AppLanguage.tamil:
        return kGlobalDisclaimerTa;
      case AppLanguage.telugu:
        return kGlobalDisclaimerTe;
    }
  }

  /// Short "not SEBI-registered" badge line — used right next to any
  /// figures/percentages in Module A so the disclaimer sits with the
  /// number itself, not just far away in a footer.
  static String notSebiBadge(AppLanguage lang) {
    switch (lang) {
      case AppLanguage.english:
        return 'Not a SEBI-registered adviser · Educational only · Invest at your own risk';
      case AppLanguage.hindi:
        return 'हम SEBI-पंजीकृत सलाहकार नहीं हैं · केवल शैक्षणिक · निवेश अपने जोखिम पर करें';
      case AppLanguage.bhojpuri:
        return 'हमनी SEBI-पंजीकृत सलाहकार ना हईं · खाली शैक्षणिक · निवेश अपना जोखिम पर करीं';
      case AppLanguage.marathi:
        return 'आम्ही SEBI-नोंदणीकृत सल्लागार नाही · केवळ शैक्षणिक · गुंतवणूक स्वतःच्या जोखमीवर करा';
      case AppLanguage.bengali:
        return 'আমরা SEBI-নিবন্ধিত পরামর্শদাতা নই · শুধুমাত্র শিক্ষামূলক · নিজ ঝুঁকিতে বিনিয়োগ করুন';
      case AppLanguage.tamil:
        return 'நாங்கள் SEBI-பதிவு செய்யப்பட்ட ஆலோசகர் அல்ல · கல்விக்காக மட்டுமே · உங்கள் சொந்த ஆபத்தில் முதலீடு செய்யவும்';
      case AppLanguage.telugu:
        return 'మేము SEBI-నమోదిత సలహాదారు కాదు · విద్యా ప్రయోజనాల కోసం మాత్రమే · మీ స్వంత రిస్క్‌పై పెట్టుబడి పెట్టండి';
    }
  }

  /// Punchy marquee-footer warning — shown continuously scrolling on every
  /// screen (short/high-impact, unlike the full gate-screen disclaimer).
  static String marqueeWarning(AppLanguage lang) {
    switch (lang) {
      case AppLanguage.english:
        return '⚠️ Warning: CAPX is for financial education and awareness ONLY. '
            'We are NOT a SEBI-registered adviser. Use your own judgement before '
            'any investment — every investment carries market risk, and you '
            'invest entirely at your own risk.';
      case AppLanguage.hindi:
        return '⚠️ चेतावनी: यह CAPX ऐप केवल वित्तीय शिक्षा और जागरूकता (Educational '
            'Purposes) के लिए है। हम कोई SEBI रजिस्टर्ड एडवाइज़र नहीं हैं। कोई भी निवेश '
            'करने से पहले अपने विवेक का इस्तेमाल करें, हर निवेश में बाज़ार का जोखिम शामिल है '
            'और ग्राहक पूरी तरह अपने रिस्क पर ही इन्वेस्ट करें।';
      case AppLanguage.bhojpuri:
        return '⚠️ चेतावनी: ई CAPX ऐप खाली वित्तीय शिक्षा आ जागरूकता खातिर बा। हमनी '
            'कवनो SEBI रजिस्टर्ड एडवाइज़र ना हईं। कवनो निवेश करे से पहिले अपना विवेक के '
            'इस्तेमाल करीं, हर निवेश में बाज़ार के जोखिम शामिल बा आ ग्राहक पूरा तरह अपना '
            'रिस्क पर ही इन्वेस्ट करीं।';
      case AppLanguage.marathi:
        return '⚠️ इशारा: हे CAPX अ‍ॅप केवळ आर्थिक शिक्षण आणि जागरूकतेसाठी आहे. आम्ही '
            'कोणतेही SEBI नोंदणीकृत सल्लागार नाही. कोणतीही गुंतवणूक करण्यापूर्वी स्वतःचा '
            'विवेक वापरा, प्रत्येक गुंतवणुकीत बाजार जोखीम असते आणि ग्राहकाने पूर्णपणे '
            'स्वतःच्या जोखमीवर गुंतवणूक करावी.';
      case AppLanguage.bengali:
        return '⚠️ সতর্কতা: এই CAPX অ্যাপটি শুধুমাত্র আর্থিক শিক্ষা ও সচেতনতার জন্য। '
            'আমরা কোনো SEBI নিবন্ধিত পরামর্শদাতা নই। কোনো বিনিয়োগ করার আগে নিজের '
            'বিবেচনা ব্যবহার করুন, প্রতিটি বিনিয়োগে বাজারের ঝুঁকি থাকে এবং গ্রাহক '
            'সম্পূর্ণভাবে নিজের ঝুঁকিতেই বিনিয়োগ করবেন।';
      case AppLanguage.tamil:
        return '⚠️ எச்சரிக்கை: இந்த CAPX ஆப் நிதி கல்வி மற்றும் விழிப்புணர்வுக்காக '
            'மட்டுமே. நாங்கள் எந்த SEBI-பதிவு செய்யப்பட்ட ஆலோசகரும் அல்ல. எந்த '
            'முதலீட்டையும் செய்வதற்கு முன் உங்கள் சொந்த விவேகத்தைப் பயன்படுத்துங்கள், '
            'ஒவ்வொரு முதலீட்டிலும் சந்தை ஆபத்து உள்ளது, மேலும் வாடிக்கையாளர் முழுவதுமாக '
            'தன் சொந்த ஆபத்தில் முதலீடு செய்ய வேண்டும்.';
      case AppLanguage.telugu:
        return '⚠️ హెచ్చరిక: ఈ CAPX యాప్ కేవలం ఆర్థిక విద్య మరియు అవగాహన కోసం మాత్రమే. '
            'మేము ఏ SEBI-నమోదిత సలహాదారు కాదు. ఏదైనా పెట్టుబడి పెట్టే ముందు మీ స్వంత '
            'విచక్షణను ఉపయోగించండి, ప్రతి పెట్టుబడిలో మార్కెట్ రిస్క్ ఉంటుంది మరియు '
            'కస్టమర్ పూర్తిగా తన స్వంత రిస్క్‌పైనే పెట్టుబడి పెట్టాలి.';
    }
  }

  /// Module B specific banner: makes clear the merchant suite is business
  /// education / case-study material, not certified legal/business
  /// consulting, and CAPX takes no responsibility for business outcomes.
  static String moduleBDisclaimer(AppLanguage lang) {
    switch (lang) {
      case AppLanguage.english:
        return 'This CAPX Merchant Suite is for business education and case '
            'studies only. We are not responsible for any business profit or '
            'loss. This is not certified legal consultation.';
      case AppLanguage.hindi:
        return 'यह CAPX मर्चेंट सूट केवल व्यावसायिक शिक्षा और केस स्टडीज के लिए है। हम '
            'किसी भी व्यावसायिक लाभ या हानि के लिए जिम्मेदार नहीं हैं। यह कोई प्रमाणित '
            'कानूनी परामर्श नहीं है।';
      case AppLanguage.bhojpuri:
        return 'ई CAPX मर्चेंट सूट खाली व्यावसायिक शिक्षा आ केस स्टडीज खातिर बा। हमनी '
            'कवनो व्यावसायिक लाभ भा हानि खातिर जिम्मेदार ना हईं। ई कवनो प्रमाणित कानूनी '
            'परामर्श ना ह।';
      case AppLanguage.marathi:
        return 'हे CAPX मर्चंट सुइट केवळ व्यावसायिक शिक्षण आणि केस स्टडीजसाठी आहे. '
            'कोणत्याही व्यावसायिक नफ्या-तोट्यासाठी आम्ही जबाबदार नाही. हा कोणताही '
            'प्रमाणित कायदेशीर सल्ला नाही.';
      case AppLanguage.bengali:
        return 'এই CAPX মার্চেন্ট স্যুট শুধুমাত্র ব্যবসায়িক শিক্ষা এবং কেস স্টাডির জন্য। '
            'আমরা কোনো ব্যবসায়িক লাভ বা ক্ষতির জন্য দায়ী নই। এটি কোনো প্রত্যয়িত আইনি '
            'পরামর্শ নয়।';
      case AppLanguage.tamil:
        return 'இந்த CAPX மர்ச்சண்ட் சூட் வணிக கல்வி மற்றும் கேஸ் ஸ்டடீஸ்களுக்காக '
            'மட்டுமே. எந்த வணிக லாபம் அல்லது நஷ்டத்திற்கும் நாங்கள் பொறுப்பல்ல. இது '
            'உரிமம் பெற்ற சட்ட ஆலோசனை அல்ல.';
      case AppLanguage.telugu:
        return 'ఈ CAPX మర్చంట్ సూట్ వ్యాపార విద్య మరియు కేస్ స్టడీస్ కోసం మాత్రమే. '
            'ఏదైనా వ్యాపార లాభం లేదా నష్టానికి మేము బాధ్యులం కాదు. ఇది సర్టిఫైడ్ న్యాయ '
            'సలహా కాదు.';
    }
  }


  static const Map<String, Map<AppLanguage, String>> _table = {
    'app_name': {
      AppLanguage.english: 'CAPX',
      AppLanguage.hindi: 'CAPX',
      AppLanguage.bhojpuri: 'CAPX',
      AppLanguage.marathi: 'CAPX',
      AppLanguage.bengali: 'CAPX',
      AppLanguage.tamil: 'CAPX',
      AppLanguage.telugu: 'CAPX',
    },
    'app_tagline': {
      AppLanguage.english: 'CAPX - Financial & Merchant Suite',
      AppLanguage.hindi: 'CAPX - फाइनेंशियल एंड मर्चेंट सूट',
      AppLanguage.bhojpuri: 'CAPX - फाइनेंशियल एंड मर्चेंट सूट',
      AppLanguage.marathi: 'CAPX - फायनान्शियल अँड मर्चंट सुइट',
      AppLanguage.bengali: 'CAPX - ফিন্যান্সিয়াল অ্যান্ড মার্চেন্ট স্যুট',
      AppLanguage.tamil: 'CAPX - நிதி & மர்ச்சண்ட் சூட்',
      AppLanguage.telugu: 'CAPX - ఫైనాన్షియల్ & మర్చంట్ సూట్',
    },
    'dashboard_title': {
      AppLanguage.english: 'Home',
      AppLanguage.hindi: 'होम',
      AppLanguage.bhojpuri: 'होम',
      AppLanguage.marathi: 'मुख्यपृष्ठ',
      AppLanguage.bengali: 'হোম',
      AppLanguage.tamil: 'முகப்பு',
      AppLanguage.telugu: 'హోమ్',
    },
    'card_a_title': {
      AppLanguage.english: 'Mass Market Investment & Savings Guide',
      AppLanguage.hindi: 'मास मार्केट निवेश और बचत गाइड',
      AppLanguage.bhojpuri: 'मास मार्केट निवेश आ बचत गाइड',
      AppLanguage.marathi: 'मास मार्केट गुंतवणूक आणि बचत मार्गदर्शक',
      AppLanguage.bengali: 'ম্যাস মার্কেট বিনিয়োগ ও সঞ্চয় গাইড',
      AppLanguage.tamil: 'மாஸ் மார்க்கெட் முதலீடு & சேமிப்பு வழிகாட்டி',
      AppLanguage.telugu: 'మాస్ మార్కెట్ ఇన్వెస్ట్‌మెంట్ & సేవింగ్స్ గైడ్',
    },
    'card_a_price': {
      AppLanguage.english: '₹29 · One-time',
      AppLanguage.hindi: '₹29 · एक बार',
      AppLanguage.bhojpuri: '₹29 · एक बेर',
      AppLanguage.marathi: '₹29 · एकदाच',
      AppLanguage.bengali: '₹29 · একবার',
      AppLanguage.tamil: '₹29 · ஒரு முறை',
      AppLanguage.telugu: '₹29 · ఒకసారి',
    },
    'card_b_title': {
      AppLanguage.english: 'Digital Merchant Rescue Suite',
      AppLanguage.hindi: 'डिजिटल मर्चेंट रेस्क्यू सुइट',
      AppLanguage.bhojpuri: 'डिजिटल मर्चेंट रेस्क्यू सुइट',
      AppLanguage.marathi: 'डिजिटल मर्चंट रेस्क्यू सुइट',
      AppLanguage.bengali: 'ডিজিটাল মার্চেন্ট রেসকিউ স্যুট',
      AppLanguage.tamil: 'டிஜிட்டல் மர்ச்சண்ட் ரெஸ்க்யூ சூட்',
      AppLanguage.telugu: 'డిజిటల్ మర్చంట్ రెస్క్యూ సూట్',
    },
    'card_b_price': {
      AppLanguage.english: '₹1,499 · Annual',
      AppLanguage.hindi: '₹1,499 · सालाना',
      AppLanguage.bhojpuri: '₹1,499 · हर साल',
      AppLanguage.marathi: '₹1,499 · वार्षिक',
      AppLanguage.bengali: '₹1,499 · বার্ষিক',
      AppLanguage.tamil: '₹1,499 · வருடாந்திரம்',
      AppLanguage.telugu: '₹1,499 · వార్షికం',
    },
    'card_c_title': {
      AppLanguage.english: 'Premium Startup Advisory & Problem Solver',
      AppLanguage.hindi: 'प्रीमियम स्टार्टअप एडवाइजरी',
      AppLanguage.bhojpuri: 'प्रीमियम स्टार्टअप एडवाइजरी',
      AppLanguage.marathi: 'प्रीमियम स्टार्टअप सल्ला',
      AppLanguage.bengali: 'প্রিমিয়াম স্টার্টআপ পরামর্শ',
      AppLanguage.tamil: 'பிரீமியம் ஸ்டார்ட்அப் ஆலோசனை',
      AppLanguage.telugu: 'ప్రీమియం స్టార్టప్ అడ్వైజరీ',
    },
    'card_c_price': {
      AppLanguage.english: '₹2,499 · Package',
      AppLanguage.hindi: '₹2,499 · पैकेज',
      AppLanguage.bhojpuri: '₹2,499 · पैकेज',
      AppLanguage.marathi: '₹2,499 · पॅकेज',
      AppLanguage.bengali: '₹2,499 · প্যাকেজ',
      AppLanguage.tamil: '₹2,499 · தொகுப்பு',
      AppLanguage.telugu: '₹2,499 · ప్యాకేజీ',
    },
    'continue': {
      AppLanguage.english: 'Continue',
      AppLanguage.hindi: 'आगे बढ़ें',
      AppLanguage.bhojpuri: 'आगे बढ़ीं',
      AppLanguage.marathi: 'पुढे जा',
      AppLanguage.bengali: 'এগিয়ে যান',
      AppLanguage.tamil: 'தொடரவும்',
      AppLanguage.telugu: 'కొనసాగించండి',
    },
    'pay_now': {
      AppLanguage.english: 'Pay Now',
      AppLanguage.hindi: 'अभी भुगतान करें',
      AppLanguage.bhojpuri: 'अभिन भुगतान करीं',
      AppLanguage.marathi: 'आता पैसे भरा',
      AppLanguage.bengali: 'এখনই পেমেন্ট করুন',
      AppLanguage.tamil: 'இப்போது பணம் செலுத்துங்கள்',
      AppLanguage.telugu: 'ఇప్పుడే చెల్లించండి',
    },
    'i_understand_continue': {
      AppLanguage.english: 'I Understand, Continue',
      AppLanguage.hindi: 'मुझे समझ आया, आगे बढ़ें',
      AppLanguage.bhojpuri: 'हमरा समझ में आ गइल, आगे बढ़ीं',
      AppLanguage.marathi: 'मला समजले, पुढे जा',
      AppLanguage.bengali: 'আমি বুঝেছি, এগিয়ে যান',
      AppLanguage.tamil: 'எனக்குப் புரிந்தது, தொடரவும்',
      AppLanguage.telugu: 'నాకు అర్థమైంది, కొనసాగించండి',
    },
  };

  static String t(String key, AppLanguage lang) {
    final entry = _table[key];
    if (entry == null) return key;
    return entry[lang] ?? entry[AppLanguage.english] ?? key;
  }
}
