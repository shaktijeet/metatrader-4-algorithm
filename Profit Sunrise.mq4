#property copyright "Copyright © 2015 | FXProSystems.com"
#property link      "http://www.fxprosystems.com"

#property indicator_chart_window
#property indicator_buffers 2
#property indicator_color1 Lime
#property indicator_color2 Red
#property indicator_width1  2
#property indicator_width2  2
#include <MQLMySQL.mqh>

string INI;
string Query;
  string symbol = Symbol();
  int DB;
extern int add_time = 4;
double G_ibuf_76[];
double G_ibuf_80[];
int G_period_84 = 3;
int G_period_88 = 21;
extern bool Alerts = TRUE;
bool Gi_96 = FALSE;
bool Gi_100 = FALSE;

// E37F0136AA3FFAF149B351F6A4C948E9
int init() {

if(connect()==true)
 Print("connectin takes");
   SetIndexStyle(0, DRAW_ARROW, EMPTY);
   SetIndexArrow(0, 221);
   SetIndexBuffer(0, G_ibuf_76);
   SetIndexStyle(1, DRAW_ARROW, EMPTY);
   SetIndexArrow(1, 222);
   SetIndexBuffer(1, G_ibuf_80);
   return (0);
}

// 52D46093050F38C27267BCE42543EF60
int deinit() {
   return (0);
}

// EA2B2676C28C0DB26D39331A336C6B92
int start() {
   int Li_0;
   double ima_4;
   double ima_12;
   double ima_20;
   double ima_28;
   double ima_36;
   double ima_44;
   double Ld_52;
   double Ld_60;
   string Ls_68;
   //int str2time_76;
   int Li_80;
   int Li_84;
   if (IsTesting() == FALSE) {
      /*if (AccountNumber() != 3114221) {
         Alert("Èíäèêàòîð íå àêòèâèðîâàí!");
         return (0);
      }
      Ls_68 = "2018.11.01";
      str2time_76 = StrToTime(Ls_68);
      if (TimeCurrent() >= str2time_76) {
         Alert(" Trial version has expired! Email support@profitsunrise.ru with broker account number for rights to full version!");
         return (0);
      }*/
      Li_80 = IndicatorCounted();
      if (Li_80 < 0) return (-1);
      if (Li_80 > 0) Li_80--;
      Li_84 = Bars - Li_80;
      for (int Li_88 = 0; Li_88 <= Li_84; Li_88++) {
         Li_0 = Li_88;
         Ld_52 = 0;
         Ld_60 = 0;
         for (Li_0 = Li_88; Li_0 <= Li_88 + 9; Li_0++) Ld_60 += MathAbs(High[Li_0] - Low[Li_0]);
         Ld_52 = Ld_60 / 10.0;
         ima_4 = iMA(NULL, 0, G_period_84, 0, MODE_EMA, PRICE_CLOSE, Li_88);
         ima_20 = iMA(NULL, 0, G_period_84, 0, MODE_EMA, PRICE_CLOSE, Li_88 + 1);
         ima_36 = iMA(NULL, 0, G_period_84, 0, MODE_EMA, PRICE_CLOSE, Li_88 - 1);
         ima_12 = iMA(NULL, 0, G_period_88, 0, MODE_EMA, PRICE_CLOSE, Li_88);
         ima_28 = iMA(NULL, 0, G_period_88, 0, MODE_EMA, PRICE_CLOSE, Li_88 + 1);
         ima_44 = iMA(NULL, 0, G_period_88, 0, MODE_EMA, PRICE_CLOSE, Li_88 - 1);
         if (ima_4 > ima_12 && ima_20 < ima_28 && ima_36 > ima_44) {
            G_ibuf_76[Li_88] = Low[Li_88] - Ld_52 / 2.0;
            if (Li_88 <= 2 && Alerts && (!Gi_96)) {
               Alert(Symbol(), " ", Period(), " Profit Sunrise BUY Alert ");
               //write the code send data in own websites 
               
               string call = "CALL";
                Print(call);
                 int timmers =TimeMinute(TimeLocal())+add_time;
                 Query =         "INSERT INTO `mql` (current_price, currency_pair, optiontype,	expiry) VALUES ("+DoubleToString(SymbolInfoDouble(Symbol(), SYMBOL_BID), _Digits)+",\'"+symbol+"\'  ,\'"+call+"\',\'"+IntegerToString(timmers)+"\');";
                 if (MySqlExecute(DB, Query))
                                          {
                                             Print ("Succeeded! 3 rows has been inserted by one query.");
                                           }
                    else
                            {
                                     Print ("Error of multiple statements: ", MySqlErrorDescription);
                                }
               
               Gi_96 = TRUE;
               Gi_100 = FALSE;
            }
         } else {
            if (ima_4 < ima_12 && ima_20 > ima_28 && ima_36 < ima_44) {
               G_ibuf_80[Li_88] = High[Li_88] + Ld_52 / 2.0;
               if (Li_88 <= 2 && Alerts && (!Gi_100)) {
                  Alert(Symbol(), " ", Period(), " Profit Sunrise SELL Alert ");
                  //write the for sending data to rhe web action in the specified manner
                        string put = "PUT";
            Print(put);
            int timmer =TimeMinute(TimeLocal())+add_time;
               Query =         "INSERT INTO `mql` (current_price, currency_pair,optiontype) VALUES ("+DoubleToString(SymbolInfoDouble(Symbol(), SYMBOL_BID), _Digits)+",\'"+symbol+"\' ,\'"+put+"\',\'"+IntegerToString(timmer)+"\');";
     if (MySqlExecute(DB, Query))
        {
         Print ("Succeeded! 3 rows has been inserted by one query.");
        }
     else
        {
         Print ("Error of multiple statements: ", MySqlErrorDescription);
        }
                  
                  
                  
                  Gi_100 = TRUE;
                  Gi_96 = FALSE;
               }
            }
         }
      }
   }
   return (0);
}


int connect(){



 // database identifiers
 
 Print (MySqlVersion());

 
 
 DB = MySqlConnect("localhost","root","","trading",3306,"", 0);
 
 // open database connection
 Print ("Connecting...");
 
 //DB = MySqlConnect(Host, User, Password, Database, Port, Socket, ClientFlag);
 
  
 if (DB == -1) 
 
 
 
 { 
 Print ("Connection failed! Error: "+MySqlErrorDescription);
 
 return false;
 
 
 
  } 
 
 
 
 
 else { Print ("Connected! DBID#",DB);
 
 return true;
 }
 

 //Query = "DROP TABLE IF EXISTS `test_table`";
 //MySqlExecute(DB, Query);
 
// Query = "CREATE TABLE `test_table` (id varchar (100), code varchar(50), start_date datetime)";
 //if (MySqlExecute(DB, Query))
  //  {
    // Print ("Table `test_table` created.");
     
    


}