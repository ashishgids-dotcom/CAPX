/// Real-world problem → practical solution playbooks for each of the 4Ps
/// plus Performance. This is what makes Module C more than "just a video
/// call" — every sub-tab carries concrete, common founder problems with
/// actionable next steps, on top of the calculators already in each tab.
class ProblemSolution {
  final String problem;
  final String solution;

  const ProblemSolution({required this.problem, required this.solution});
}

// ---------------------------------------------------------------------------
// PRODUCT & PRICE
// ---------------------------------------------------------------------------
const List<ProblemSolution> productPriceProblems = [
  ProblemSolution(
    problem: 'Mera product bahut acha hai lekin koi khareed nahi raha.',
    solution:
        '"Good product" aur "product people will pay for" alag cheezein hain. '
        '10 potential customers se seedha poocho: "Isko na khareedne ki sabse '
        'badi wajah kya hai?" — price, trust, awareness, ya zaroorat na hona. '
        'Jawab se hi pata chalega kaunsa P (Product/Price/Promotion) actual '
        'blocker hai.',
  ),
  ProblemSolution(
    problem: 'Competitor mujhse sasta bech raha hai, main kaise compete karun?',
    solution:
        'Price war mein na jao — margin khatam ho jaayega. Instead, ek chhota '
        'differentiator dhoondo (faster delivery, better packaging, after-sale '
        'support, bundle offer) jo competitor asaani se copy na kar sake. '
        'Pricing Architecture Engine (upar) se apna sahi margin nikaal ke '
        'wahi rakho — race to the bottom mein mat jao.',
  ),
  ProblemSolution(
    problem: 'Customers product try karte hain lekin dobara nahi aate.',
    solution:
        'Yeh retention problem hai, acquisition nahi. Pehli purchase ke 48 '
        'ghante ke andar ek follow-up message bhejo (feedback + chhota '
        'discount agla order pe). Product Market Fit Tester score bhi check '
        'karo — agar usability/packaging low hai, wahi churn ka reason ho '
        'sakta hai.',
  ),
];

// ---------------------------------------------------------------------------
// PROMOTION (Sales & Marketing)
// ---------------------------------------------------------------------------
const List<ProblemSolution> promotionProblems = [
  ProblemSolution(
    problem: 'Marketing budget bahut kam hai, kahan se shuru karun?',
    solution:
        'Zero-budget se shuru karo: apne existing customers se referral maango '
        '(ek chhota incentive ke saath), WhatsApp Status/Broadcast use karo, '
        'aur ek local Facebook/community group mein genuinely help karke '
        'apna naam bana lo. Paid ads sirf tab try karo jab organic se kam se '
        'kam 10 real conversions mil chuke hon — tabhi pata chalega konsa '
        'messaging kaam karta hai.',
  ),
  ProblemSolution(
    problem: 'Social media par post karta hoon lekin koi engagement nahi milta.',
    solution:
        'Zyada products dikhane ke bajaye "before/after" ya "problem→solution" '
        'wale 15-second video try karo — yeh feed mein rukwate hain. Pehle 3 '
        'second mein hi problem bolo, warna log scroll kar jaayenge. Ek '
        'hafte mein 3-4 alag hooks test karo, jo best chale usi style ko '
        'double karo.',
  ),
  ProblemSolution(
    problem: 'B2B leads milte hi nahi, cold outreach kaam nahi karta.',
    solution:
        'Generic "Hi, we sell X" message ignore hota hai. Uske bajaye us '
        'company ka ek specific problem mention karo jo tumhara product solve '
        'karta hai, 2-line mein. 1 follow-up message 3 din baad, doosra 1 '
        'hafte baad — teen se zyada follow-up mat karo, ispe pushy lagta hai.',
  ),
];

// ---------------------------------------------------------------------------
// PLACE (Distribution & Logistics)
// ---------------------------------------------------------------------------
const List<ProblemSolution> placeProblems = [
  ProblemSolution(
    problem: 'Delivery cost bahut zyada pad rahi hai chhoti orders par.',
    solution:
        'Ek minimum order value set karo jispe free delivery ho (taaki '
        'customer thoda zyada order kare), aur usse neeche flat delivery '
        'charge lagao. Nearby area ke orders ek din mein batch karke bhejo '
        'instead of ek-ek karke — isse per-order cost kam hota hai.',
  ),
  ProblemSolution(
    problem: 'Stock kabhi zyada ho jaata hai kabhi khatam ho jaata hai.',
    solution:
        'Pichle 4 hafton ka sales data dekho, average nikaal ke ek simple '
        '"reorder point" set karo (jab stock utna reh jaaye, turant reorder '
        'karo). Fast-moving aur slow-moving items alag track karo — dono ko '
        'same tarike se stock mat karo.',
  ),
  ProblemSolution(
    problem: 'Online platforms (ONDC/Zepto/Blinkit) par onboard kaise karun?',
    solution:
        'Pehle apna GST aur FSSAI (agar food hai) ready rakho — yeh sabse '
        'zyada onboarding delay karte hain. ONDC ke liye kisi ek buyer/seller '
        'app se juड़ी hui seller-app se register karo (khud ONDC directly '
        'onboard nahi karta). Quick-commerce ke liye unke seller-partner '
        'portal se apply karo, shuru mein 10-15 fast-moving SKUs se hi list '
        'karo.',
  ),
];

// ---------------------------------------------------------------------------
// PERFORMANCE (Metrics-related real-world problems)
// ---------------------------------------------------------------------------
const List<ProblemSolution> performanceProblems = [
  ProblemSolution(
    problem: 'Sales toh ho rahi hai lekin paisa bachta hi nahi.',
    solution:
        'Revenue aur profit alag hain. Neeche KPI tracker mein apna CAC aur '
        'burn rate daalo — agar CAC, customer se milne wale profit se zyada '
        'hai, toh har naya customer tumhe ulta nuksaan de raha hai. Pehle '
        'yeh gap band karo, tabhi scale karo.',
  ),
  ProblemSolution(
    problem: 'Runway kam lag raha hai, funding nahi mili to kya karun?',
    solution:
        'Sabse pehle non-essential kharcha rokoo (extra tools, unused ads). '
        'Fir dekho kaunsa product/service sabse zyada margin deta hai, usi '
        'par focus badhao. Agar phir bhi runway 3 mahine se kam hai, revenue-'
        'based bridge (advance orders, pre-booking) try karo funding dhoondte '
        'waqt.',
  ),
  ProblemSolution(
    problem: 'Kaunsa metric sabse pehle dekhna chahiye jab busy ho?',
    solution:
        'Agar sirf ek cheez dekh sakte ho, toh Runway dekho — yeh batata hai '
        'kitna time bacha hai decisions lene ke liye. Uske baad CAC vs LTV '
        'ratio dekho (LTV kam se kam 3x CAC hona chahiye, warna business '
        'sustainable nahi hai).',
  ),
];
