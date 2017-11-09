//+------------------------------------------------------------------+
//|                                             DXTrade C4 Nitro.mq4 |
//|                                Copyright © 2016 FXProSystems.com |
//|                                         http://fxprosystems.com/ |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2016 | FXProSystems.com"
#property link      "http://fxprosystems.com"

#property indicator_chart_window
#property indicator_buffers 2
#property indicator_color1 DodgerBlue
#property indicator_color2 Red
#property indicator_width1 2
#property indicator_width2 2

extern int Trix_Period = 2;
extern int Period_MA = 10;
double Gd_unused_84 = 0.0;
string Gs_unused_92 = "0=SMA, 1=EMA, 2=SMMA, 3=LWMA";
int Gi_unused_100 = 1;
int Gi_unused_104 = 1;
int Gi_unused_108 = 1;
string Gs_unused_112 = "0=C,4=Median,5=Typical,6=Weighted";
int Gi_unused_120 = 0;
string Gs_unused_124 = "";
int G_ma_method_132 = MODE_LWMA;
int G_applied_price_136 = PRICE_WEIGHTED;
extern int MOM_Period = 4;
extern bool Alert_Signals = TRUE;
extern bool Sound_On = TRUE;
string Gs_unused_152 = "Change font colors automatically? True = Yes";
extern bool Change_Colors = TRUE;
extern string note2 = "Default Font Colors";
extern color FontColor = DodgerBlue;
extern color FontUp = Lime;
extern color FontDown = Red;
extern color BoxColor = C'0x2B,0x2B,0x2B';
color G_color_188 = Black;
color G_color_192 = Black;
int Gi_unused_196 = 0;
color G_color_200 = Black;
color G_color_204 = Black;
color G_color_208 = Black;
string Gs_unused_212 = "Font Size";
int G_fontsize_220 = 16;
int G_fontsize_224 = 10;
string G_fontname_228 = "Century Gothic";
extern string note4 = "Distance of Indicator";
extern int shiftx = 5;
extern int shifty = 20;
extern string note5 = "What corner?";
extern string note6 = "Upper left=0; Upper right=1";
extern string note7 = "Lower left=2; Lower right=3";
extern int WhatCorner = 1;
double G_bid_280;
string G_text_288;
string G_text_296;
string G_text_304;
string G_text_312;
int Gi_320 = 15000;
int G_period_324 = 0;
double Gd_328 = 1000.0;
double Gda_336[];
double Gda_340[];
double Gda_344[];
double Gda_348[];
double Gda_352[];
double Gda_356[];
double Gda_360[];
double Gda_364[];
double G_ibuf_368[];
double G_ibuf_372[];
bool Gi_376 = FALSE;
bool Gi_380 = FALSE;
int G_ma_method_384;
int G_ma_method_388;
int G_ma_method_392;
int G_applied_price_396;
double Gd_400;
int G_datetime_408 = 0;
int G_datetime_412 = 0;
int G_datetime_416 = 0;
int G_datetime_420 = 0;

int init() {
   ArraySetAsSeries(Gda_336, TRUE);
   ArraySetAsSeries(Gda_340, TRUE);
   ArraySetAsSeries(Gda_364, TRUE);
   ArraySetAsSeries(Gda_352, TRUE);
   ArraySetAsSeries(Gda_356, TRUE);
   ArraySetAsSeries(Gda_360, TRUE);
   ArraySetAsSeries(Gda_344, TRUE);
   ArraySetAsSeries(Gda_348, TRUE);
   IndicatorDigits(Digits);
   SetIndexBuffer(0, G_ibuf_368);
   SetIndexStyle(0, DRAW_ARROW);
   SetIndexArrow(0, SYMBOL_ARROWUP);
   SetIndexLabel(0, "DXTrade C4 Nitro Up");
   SetIndexBuffer(1, G_ibuf_372);
   SetIndexStyle(1, DRAW_ARROW);
   SetIndexArrow(1, SYMBOL_ARROWDOWN);
   SetIndexLabel(1, "DXTrade C4 Nitro Down");
   G_ma_method_384 = 1;
   G_ma_method_388 = 1;
   G_ma_method_392 = 1;
   G_applied_price_396 = 0;
   string Ls_0 = "DXTrade C4 Nitro Meter";
   IndicatorShortName(Ls_0);
   return (0);
}

int deinit() {
   ObjectDelete("dxtrade");
   ObjectDelete("Box");
   ObjectDelete("Box2");
   ObjectDelete("Market_Price_Label");
   ObjectDelete("Trix5mLabel");
   ObjectDelete("Trix5m");
   ObjectDelete("MaLabel");
   ObjectDelete("Ma");
   ObjectDelete("Pair");
   ObjectDelete("Spread");
   ObjectDelete("Trend");
   ObjectDelete("TrendLabel");
   ObjectDelete("TrendT5");
   ObjectDelete("momLabel");
   ObjectDelete("mom");
   ObjectDelete("Trade");
   ObjectDelete("Trade2");
   return (0);
}

int start() {
   int shift_4;
   int Li_8;
   double point_12;
   string Ls_20;
   double Ld_32;
   double Ld_40;
   int Li_48;
   int Li_52;
   int Li_56;
   double ima_60;
   double iclose_68;
   int Li_76;
   int Li_80;
   bool Li_84;
   int Li_88;
   int Li_92;
   int Li_96;
   int Li_100;
   string Ls_104;
   if (Change_Colors == TRUE) {
      if (Bid > G_bid_280) G_color_200 = FontUp;
      if (Bid < G_bid_280) G_color_200 = FontDown;
      G_bid_280 = Bid;
   }
   int timeframe_0 = 0;
   if (timeframe_0 != Period()) shift_4 = iBarShift(NULL, timeframe_0, iTime(NULL, 0, Li_8));
   if (Point == 0.00001) point_12 = 0.0001;
   else {
      if (Point == 0.001) point_12 = 0.01;
      else point_12 = Point;
   }
   if (Trix_Period == G_period_324) return (0);
   ArrayResize(Gda_336, Bars);
   ArrayResize(Gda_340, Bars);
   ArrayResize(Gda_364, Bars);
   ArrayResize(Gda_352, Bars);
   ArrayResize(Gda_356, Bars);
   ArrayResize(Gda_360, Bars);
   ArrayResize(Gda_344, Bars);
   ArrayResize(Gda_348, Bars);
   int Li_28 = Gi_320;
   if (Li_28 > Bars) Li_28 = Bars - 1;
   for (Li_8 = 0; Li_8 < Li_28; Li_8++) Gda_336[Li_8] = iMA(Symbol(), Period(), Trix_Period, 0, G_ma_method_384, G_applied_price_396, Li_8);
   for (Li_8 = 0; Li_8 < Li_28; Li_8++) Gda_340[Li_8] = iMAOnArray(Gda_336, 0, Trix_Period, 0, G_ma_method_388, Li_8);
   for (Li_8 = 0; Li_8 < Li_28; Li_8++) Gda_364[Li_8] = iMAOnArray(Gda_340, 0, Trix_Period, 0, G_ma_method_392, Li_8);
   for (Li_8 = 0; Li_8 < Li_28 - 1; Li_8++)
      if (Gda_364[Li_8 + 1] != 0.0) Gda_336[Li_8] = Gd_328 * (Gda_364[Li_8] - (Gda_364[Li_8 + 1])) / (Gda_364[Li_8 + 1]);
   for (Li_8 = 0; Li_8 < Li_28 - 1; Li_8++) Gda_340[Li_8] = iMAOnArray(Gda_336, 0, G_period_324, 0, MODE_EMA, Li_8);
   for (Li_8 = 0; Li_8 < Li_28 - 1; Li_8++) {
      Ld_32 = Gda_336[Li_8] - Gda_340[Li_8];
      Gda_352[Li_8] = Ld_32;
      if (Ld_32 >= 0.0) {
         Gda_356[Li_8] = Ld_32;
         Gda_360[Li_8] = EMPTY_VALUE;
      } else {
         Gda_356[Li_8] = EMPTY_VALUE;
         Gda_360[Li_8] = Ld_32;
      }
   }
   for (Li_8 = Li_28 - 1; Li_8 >= 0; Li_8--) {
      Ld_40 = iATR(Symbol(), Period(), 10, Li_8) / 2.0;
      Li_48 = 0;
      G_ibuf_368[Li_8 + Li_48] = EMPTY_VALUE;
      G_ibuf_372[Li_8 + Li_48] = EMPTY_VALUE;
      Li_52 = Gda_356[Li_8 + Li_48] > 0.0 && Gda_356[Li_8 + Li_48] != EMPTY_VALUE && Gda_360[Li_8 + 1 + Li_48] < 0.0;
      Li_56 = Gda_360[Li_8 + Li_48] < 0.0 && Gda_356[Li_8 + 1 + Li_48] != EMPTY_VALUE && Gda_356[Li_8 + 1 + Li_48] > 0.0;
      if (Li_52 == 1) {
         if (G_datetime_416 == 0) {
            G_datetime_416 = iTime(Symbol(), Period(), Li_8 + Li_48);
            G_datetime_420 = 0;
         }
      }
      if (Li_56 == 1) {
         if (G_datetime_420 == 0) {
            G_datetime_416 = 0;
            G_datetime_420 = iTime(Symbol(), Period(), Li_8 + Li_48);
         }
      }
      ima_60 = iMA(Symbol(), Period(), Period_MA, 0, G_ma_method_132, G_applied_price_136, Li_8);
      iclose_68 = iClose(Symbol(), Period(), Li_8 + Li_48);
      Li_76 = iclose_68 > ima_60;
      Li_80 = iclose_68 < ima_60;
      if (Li_76 == 1) {
         if (G_datetime_408 == 0) {
            G_datetime_408 = iTime(Symbol(), Period(), Li_8 + Li_48);
            G_datetime_412 = 0;
         }
      }
      if (Li_80 == 1) {
         if (G_datetime_412 == 0) {
            G_datetime_408 = 0;
            G_datetime_412 = iTime(Symbol(), Period(), Li_8 + Li_48);
         }
      }
      Li_84 = FALSE;
      if (Li_52 == 1 && Li_76 == 1) {
         Li_88 = iTime(Symbol(), Period(), Li_8 + Li_48) - G_datetime_408;
         Li_92 = iTime(Symbol(), Period(), Li_8 + Li_48) - G_datetime_416;
         Li_84 = Li_88 >= Gd_400 && Li_92 >= Gd_400;
      } else {
         if (Li_56 == 1 && Li_80 == 1) {
            Li_88 = iTime(Symbol(), Period(), Li_8 + Li_48) - G_datetime_412;
            Li_92 = iTime(Symbol(), Period(), Li_8 + Li_48) - G_datetime_420;
            Li_84 = Li_88 >= Gd_400 && Li_92 >= Gd_400;
         }
      }
      Li_96 = Li_52 == 1 && Li_76 == 1 && Li_84 == TRUE;
      Li_100 = Li_56 == 1 && Li_80 == 1 && Li_84 == TRUE;
      if (Li_96 == 1) {
         G_ibuf_368[Li_8 + Li_48] = Low[Li_8 + Li_48] - Ld_40;
         G_ibuf_372[Li_8 + Li_48] = EMPTY_VALUE;
      } else {
         if (Li_100 == 1) {
            G_ibuf_368[Li_8 + Li_48] = EMPTY_VALUE;
            G_ibuf_372[Li_8 + Li_48] = High[Li_8 + Li_48] + Ld_40;
         }
      }
      Ls_104 = Get_sPeriod(Period());
      if (Li_8 == 0) {
         if (Alert_Signals == TRUE) {
            if (Li_96 && Gi_376 == FALSE) {
               Ls_20 = "DXTrade C4/Nitro BUY:  " + Symbol() + "  @  " + DoubleToStr(Close[0], Digits) + "  (" + TimeToStr(TimeCurrent(), TIME_MINUTES) + ")";
               if (Alert_Signals == TRUE) Alert(Ls_20);
               if (Sound_On == TRUE) PlaySound("analyzebuy.wav");
               Gi_380 = FALSE;
               Gi_376 = TRUE;
               continue;
            }
            if (Li_100 && Gi_380 == FALSE) {
               Ls_20 = "DXTrade C4/Nitro SELL:  " + Symbol() + "  @  " + DoubleToStr(Close[0], Digits) + "  (" + TimeToStr(TimeCurrent(), TIME_MINUTES) + ")";
               if (Alert_Signals == TRUE) Alert(Ls_20);
               if (Sound_On == TRUE) PlaySound("analyzesell.wav");
               Gi_380 = TRUE;
               Gi_376 = FALSE;
            }
         }
      }
   }
   string dbl2str_112 = DoubleToStr(Bid, Digits);
   string Ls_120 = AccountCurrency();
   string dbl2str_128 = DoubleToStr(NormalizeDouble((Ask - Bid) / point_12, 0), 0);
   double Ld_136 = Gda_336[shift_4];
   double Ld_144 = Gda_336[shift_4 + 1];
   double Ld_152 = Gda_336[shift_4 + 2];
   double ima_160 = iMA(NULL, timeframe_0, Period_MA, 0, G_ma_method_132, G_applied_price_136, shift_4);
   double ima_168 = iMA(NULL, timeframe_0, Period_MA, 0, G_ma_method_132, G_applied_price_136, shift_4 + 1);
   double imomentum_176 = iMomentum(NULL, timeframe_0, MOM_Period, PRICE_CLOSE, shift_4);
   string text_184 = DoubleToStr(imomentum_176, 2);
   string Ls_192 = CharToStr(77);
   string Ls_200 = CharToStr(77);
   string Ls_208 = CharToStr(73);
   if (Ld_136 > 0.0) G_color_188 = FontUp;
   if (Ld_136 < 0.0) G_color_188 = FontDown;
   if (Ld_136 > 0.0) G_text_288 = CharToStr(77);
   if (Ld_136 < 0.0) G_text_288 = CharToStr(77);
   if (Ld_144 > 0.0 && Ld_152 < 0.0) G_color_208 = FontUp;
   if (Ld_144 < 0.0 && Ld_152 > 0.0) G_color_208 = FontDown;
   if (Ld_144 > 0.0 && Ld_152 < 0.0) G_text_304 = "Buy";
   if (Ld_144 < 0.0 && Ld_152 > 0.0) G_text_304 = "Sell";
   if (Ld_144 > 0.0 && Ld_152 > 0.0) G_color_208 = FontColor;
   if (Ld_144 > 0.0 && Ld_152 > 0.0) G_text_304 = "Wait";
   if (Ld_144 < 0.0 && Ld_152 < 0.0) G_color_208 = FontColor;
   if (Ld_144 < 0.0 && Ld_152 < 0.0) G_text_304 = "Wait";
   if (Ld_144 > 0.0 && Ld_152 < 0.0) G_text_312 = Ls_192;
   if (Ld_144 < 0.0 && Ld_152 > 0.0) G_text_312 = Ls_200;
   if (Ld_144 > 0.0 && Ld_152 > 0.0) G_text_312 = Ls_208;
   if (Ld_144 < 0.0 && Ld_152 < 0.0) G_text_312 = Ls_208;
   if (ima_160 > ima_168) G_color_192 = FontUp;
   if (ima_160 < ima_168) G_color_192 = FontDown;
   if (ima_160 == ima_168) G_color_192 = FontColor;
   if (ima_160 > ima_168) G_text_296 = CharToStr(77);
   if (ima_160 < ima_168) G_text_296 = CharToStr(77);
   if (ima_160 == ima_168) G_text_296 = CharToStr(77);
   if (imomentum_176 > 100.0) G_color_204 = FontUp;
   if (imomentum_176 < 100.0) G_color_204 = FontDown;
   if (imomentum_176 == 100.0) G_color_204 = FontColor;
   if (imomentum_176 > 100.0) text_184 = CharToStr(77);
   if (imomentum_176 < 100.0) text_184 = CharToStr(77);
   if (imomentum_176 == 100.0) text_184 = CharToStr(77);
   ObjectCreate("dxtrade", OBJ_LABEL, 0, 0, 0);
   ObjectSet("dxtrade", OBJPROP_XDISTANCE, shiftx + 10);
   ObjectSet("dxtrade", OBJPROP_YDISTANCE, shifty + 1);
   ObjectSetText("dxtrade", "© DXTrade C4 Nitro", 7, G_fontname_228, DarkGoldenrod);
   ObjectSet("dxtrade", OBJPROP_CORNER, WhatCorner);
   ObjectSet("dxtrade", OBJPROP_BACK, FALSE);
   ObjectCreate("Box", OBJ_LABEL, 0, 0, 0, 0, 0);
   ObjectSetText("Box", "g", 80, "Webdings", BoxColor);
   ObjectSet("Box", OBJPROP_CORNER, WhatCorner);
   ObjectSet("Box", OBJPROP_XDISTANCE, shiftx);
   ObjectSet("Box", OBJPROP_YDISTANCE, shifty);
   ObjectSet("Box", OBJPROP_COLOR, BoxColor);
   ObjectSet("Box", OBJPROP_BACK, FALSE);
   ObjectCreate("Box2", OBJ_LABEL, 0, 0, 0, 0, 0);
   ObjectSetText("Box2", "g", 80, "Webdings", BoxColor);
   ObjectSet("Box2", OBJPROP_CORNER, WhatCorner);
   ObjectSet("Box2", OBJPROP_XDISTANCE, shiftx);
   ObjectSet("Box2", OBJPROP_YDISTANCE, shifty + 40);
   ObjectSet("Box2", OBJPROP_COLOR, BoxColor);
   ObjectSet("Box2", OBJPROP_BACK, FALSE);
   ObjectCreate("Pair", OBJ_LABEL, 0, 0, 0);
   ObjectSet("Pair", OBJPROP_XDISTANCE, shiftx + 15);
   ObjectSet("Pair", OBJPROP_YDISTANCE, shifty + 12);
   ObjectSetText("Pair", Symbol(), 14, G_fontname_228, FontColor);
   ObjectSet("Pair", OBJPROP_CORNER, WhatCorner);
   ObjectSet("Pair", OBJPROP_BACK, FALSE);
   ObjectCreate("Market_Price_Label", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("Market_Price_Label", dbl2str_112, G_fontsize_220, G_fontname_228, G_color_200);
   ObjectSet("Market_Price_Label", OBJPROP_CORNER, WhatCorner);
   ObjectSet("Market_Price_Label", OBJPROP_XDISTANCE, shiftx + 20);
   ObjectSet("Market_Price_Label", OBJPROP_YDISTANCE, shifty + 30);
   ObjectSet("Market_Price_Label", OBJPROP_BACK, FALSE);
   ObjectCreate("Spread", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("Spread", "Spread: " + dbl2str_128, G_fontsize_224, "Arial", FontColor);
   ObjectSet("Spread", OBJPROP_CORNER, WhatCorner);
   ObjectSet("Spread", OBJPROP_XDISTANCE, shiftx + 22);
   ObjectSet("Spread", OBJPROP_YDISTANCE, shifty + 55);
   ObjectSet("Spread", OBJPROP_BACK, FALSE);
   ObjectCreate("Trix5mLabel", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("Trix5mLabel", "Tr", 8, "Arial", G_color_188);
   ObjectSet("Trix5mLabel", OBJPROP_CORNER, WhatCorner);
   ObjectSet("Trix5mLabel", OBJPROP_XDISTANCE, shiftx + 75);
   ObjectSet("Trix5mLabel", OBJPROP_YDISTANCE, shifty + 80);
   ObjectSet("Trix5mLabel", OBJPROP_BACK, FALSE);
   ObjectCreate("Trix5m", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("Trix5m", G_text_288, G_fontsize_224 + 2, "WingDings", G_color_188);
   ObjectSet("Trix5m", OBJPROP_CORNER, WhatCorner);
   ObjectSet("Trix5m", OBJPROP_XDISTANCE, shiftx + 68);
   ObjectSet("Trix5m", OBJPROP_YDISTANCE, shifty + 90);
   ObjectSet("Trix5m", OBJPROP_BACK, FALSE);
   ObjectCreate("MaLabel", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("MaLabel", "Ma", 8, "Arial", G_color_192);
   ObjectSet("MaLabel", OBJPROP_CORNER, WhatCorner);
   ObjectSet("MaLabel", OBJPROP_XDISTANCE, shiftx + 47);
   ObjectSet("MaLabel", OBJPROP_YDISTANCE, shifty + 80);
   ObjectSet("MaLabel", OBJPROP_BACK, FALSE);
   ObjectCreate("Ma", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("Ma", G_text_296, G_fontsize_224 + 2, "WingDings", G_color_192);
   ObjectSet("Ma", OBJPROP_CORNER, WhatCorner);
   ObjectSet("Ma", OBJPROP_XDISTANCE, shiftx + 43);
   ObjectSet("Ma", OBJPROP_YDISTANCE, shifty + 90);
   ObjectSet("Ma", OBJPROP_BACK, FALSE);
   ObjectCreate("momLabel", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("momLabel", "Mo", 8, "Arial", G_color_204);
   ObjectSet("momLabel", OBJPROP_CORNER, WhatCorner);
   ObjectSet("momLabel", OBJPROP_XDISTANCE, shiftx + 22);
   ObjectSet("momLabel", OBJPROP_YDISTANCE, shifty + 80);
   ObjectSet("momLabel", OBJPROP_BACK, FALSE);
   ObjectCreate("mom", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("mom", text_184, G_fontsize_224 + 2, "WingDings", G_color_204);
   ObjectSet("mom", OBJPROP_CORNER, WhatCorner);
   ObjectSet("mom", OBJPROP_XDISTANCE, shiftx + 18);
   ObjectSet("mom", OBJPROP_YDISTANCE, shifty + 90);
   ObjectSet("mom", OBJPROP_BACK, FALSE);
   ObjectCreate("Trade", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("Trade", G_text_304, G_fontsize_220, "Arial", G_color_208);
   ObjectSet("Trade", OBJPROP_CORNER, WhatCorner);
   ObjectSet("Trade", OBJPROP_XDISTANCE, shiftx + 45);
   ObjectSet("Trade", OBJPROP_YDISTANCE, shifty + 120);
   ObjectSet("Trade", OBJPROP_BACK, FALSE);
   ObjectCreate("Trade2", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("Trade2", G_text_312, G_fontsize_220, "WingDings", G_color_208);
   ObjectSet("Trade2", OBJPROP_CORNER, WhatCorner);
   ObjectSet("Trade2", OBJPROP_XDISTANCE, shiftx + 15);
   ObjectSet("Trade2", OBJPROP_YDISTANCE, shifty + 120);
   ObjectSet("Trade2", OBJPROP_BACK, FALSE);
   return (0);
}

string Get_sPeriod(int Ai_0) {
   if (Ai_0 == 1) return ("M1");
   if (Ai_0 == 5) return ("M5");
   if (Ai_0 == 15) return ("M15");
   if (Ai_0 == 30) return ("M30");
   if (Ai_0 == 60) return ("H1");
   if (Ai_0 == 240) return ("H4");
   if (Ai_0 == 1440) return ("D1");
   if (Ai_0 == 10080) return ("W1");
   if (Ai_0 == 43200) return ("MN1");
   return ("");
}
