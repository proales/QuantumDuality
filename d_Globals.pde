// General setup
PImage screenshot; 
int pixelSize = 7;
int sheetWidth = 20;
int sheetHeight = 20;
int numberColumns = 60;
int numberRows = 60;
int pixelColumns = pixelSize * numberColumns;
int pixelRows = pixelSize * numberRows;
int textStartX = pixelColumns * 2 + 103;
int[][] avgColors;
int canvasWidth; 
int canvasHeight;
int blendColorMode = OVERLAY;

// Midi setup
MidiBus myBus;
MidiBus myBus2;
int volume = 0;
int note = 0;
boolean step1On = true;
boolean step2On = false;
boolean step3On = false;
boolean step4On = true;
boolean step5On = true;
boolean step6On = true;

// Pixel Pusher setup.
DeviceRegistry registry;
TestObserver testObserver;
List<Strip> strips;

// Theramin setup
int brightnessAdjustment = 0;
int colorNumber = 0;
int colorOverlay = color(255, 0, 0);
int colorSelected = color(0, 255, 0);
int noteMin = 128;
int noteMax = 0;
int volumeMin = 128;
int volumeMax = 0;
boolean windDown = false;
boolean windUp = false;
int windUpTo = 0;

// Monome setup
Monome m;
boolean dirty = true;
int[][] step;
int timer;
int play_position;
int stepTime = 10;
boolean hightlightOn = true;
int[][] monomeOverlayRight;
int[][] monomeOverlayLeft;
ArrayList<Point3d> monomeOverlayLeftPoints;
boolean windMonome = false;

int[] map400 = {
  399,  398,  397,  396,  395,  394,  393,  392,  391,  390,  389,  388,  387,  386,  385,  384,  383,  382,  381,  380,
  360,  361,  362,  363,  364,  365,  366,  367,  368,  369,  370,  371,  372,  373,  374,  375,  376,  377,  378,  379,
  359,  358,  357,  356,  355,  354,  353,  352,  351,  350,  349,  348,  347,  346,  345,  344,  343,  342,  341,  340,
  320,  321,  322,  323,  324,  325,  326,  327,  328,  329,  330,  331,  332,  333,  334,  335,  336,  337,  338,  339,
  319,  318,  317,  316,  315,  314,  313,  312,  311,  310,  309,  308,  307,  306,  305,  304,  303,  302,  301,  300,
  280,  281,  282,  283,  284,  285,  286,  287,  288,  289,  290,  291,  292,  293,  294,  295,  296,  297,  298,  299,
  279,  278,  277,  276,  275,  274,  273,  272,  271,  270,  269,  268,  267,  266,  265,  264,  263,  262,  261,  260,
  240,  241,  242,  243,  244,  245,  246,  247,  248,  249,  250,  251,  252,  253,  254,  255,  256,  257,  258,  259,
  239,  238,  237,  236,  235,  234,  233,  232,  231,  230,  229,  228,  227,  226,  225,  224,  223,  222,  221,  220,
  200,  201,  202,  203,  204,  205,  206,  207,  208,  209,  210,  211,  212,  213,  214,  215,  216,  217,  218,  219,
  199,  198,  197,  196,  195,  194,  193,  192,  191,  190,  189,  188,  187,  186,  185,  184,  183,  182,  181,  180,
  160,  161,  162,  163,  164,  165,  166,  167,  168,  169,  170,  171,  172,  173,  174,  175,  176,  177,  178,  179,
  159,  158,  157,  156,  155,  154,  153,  152,  151,  150,  149,  148,  147,  146,  145,  144,  143,  142,  141,  140,
  120,  121,  122,  123,  124,  125,  126,  127,  128,  129,  130,  131,  132,  133,  134,  135,  136,  137,  138,  139,
  119,  118,  117,  116,  115,  114,  113,  112,  111,  110,  109,  108,  107,  106,  105,  104,  103,  102,  101,  100,
  80,  81,  82,  83,  84,  85,  86,  87,  88,  89,  90,  91,  92,  93,  94,  95,  96,  97,  98,  99,
  79,  78,  77,  76,  75,  74,  73,  72,  71,  70,  69,  68,  67,  66,  65,  64,  63,  62,  61,  60,
  40,  41,  42,  43,  44,  45,  46,  47,  48,  49,  50,  51,  52,  53,  54,  55,  56,  57,  58,  59,
  39,  38,  37,  36,  35,  34,  33,  32,  31,  30,  29,  28,  27,  26,  25,  24,  23,  22,  21,  20,
  0,  1,  2,  3,  4,  5,  6,  7,  8,  9,  10,  11,  12,  13,  14,  15,  16,  17,  18,  19
};