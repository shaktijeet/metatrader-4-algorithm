//+------------------------------------------------------------------+
//|                                                       moveon.mq4 |
//|                        Copyright 2017, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
extern int TakeProfit = 40;
extern int StopLoss = 20;


extern bool UseMoveToBreakeven= true;
extern int WhenToMoveBe = 100;
extern int PipsToLockIn = 5;

extern int FastMA=7;
extern int FastMaShift= 0;
 extern int FastMaMethod = 1;
 extern int FastMaAppliedTo = 2;
extern int SlowMA=20;
extern int SlowMaShift= 0;
 extern int SlowMaMethod = 1;
 extern int SlowMaAppliedTo = 2;
extern double LotSize = 0.01;
extern int MagicNumber = 1234;
extern int add_time = 4;
double pips;
//double awesome;
#include <MQLMySQL.mqh>

string INI;
string Query;
  string symbol = Symbol();
  int DB;

int init()
 {

 if(connect()==true)
 Print("connectin takes");
     double ticksize = MarketInfo(Symbol(), MODE_TICKSIZE);
     if(ticksize == 0.00001 || ticksize == 0.001)
     pips = ticksize*10;
     else pips = ticksize;
  
  return (0);
  }
int deinit()
{


return (0);
}

int start()
{
 


  if(IsNewCandle())CheckForTrade();
  
  
 
  
  return (0);
}


 bool IsNewCandle()
 {
 static  int  BarsOnChart=1234;
   if(Bars == BarsOnChart)
 
 //in the array 
    
    return (false);
    
    BarsOnChart = Bars;
   
 return (true);
 
 
 }
void CheckForTrade()
{
double PreviousFast = iMA(NULL,0,FastMA,FastMaShift,FastMaMethod, FastMaAppliedTo,2);

double CurrentFast = iMA(NULL,0,FastMA,FastMaShift,FastMaMethod, FastMaAppliedTo,1);



double PreviousSlow = iMA(NULL,0,SlowMA,SlowMaShift,SlowMaMethod, SlowMaAppliedTo,2);

double CurrentSlow =     iMA(NULL,0,SlowMA,SlowMaShift,SlowMaMethod, SlowMaAppliedTo,1);

//Awesome oscillator indicator coding start

double  current_ao = iAO(NULL, 0, 1);
double previous_ao = iAO(NULL, 0, 2);


if( PreviousFast<PreviousSlow && CurrentFast>CurrentSlow)
{
//here we write the concept of awesome ocillator

if(previous_ao<0 && current_ao > 0){

OrderEntry(0);
string call = "CALL";
Print(call);
int timmer =TimeMinute(TimeLocal())+add_time;
   Query =         "INSERT INTO `mql` (current_price, currency_pair, optiontype,	expiry) VALUES ("+DoubleToString(SymbolInfoDouble(Symbol(), SYMBOL_BID), _Digits)+",\'"+symbol+"\'  ,\'"+call+"\',\'"+IntegerToString(timmer)+"\');";
     if (MySqlExecute(DB, Query))
        {
         Print ("Succeeded! 3 rows has been inserted by one query.");
        }
     else
        {
         Print ("Error of multiple statements: ", MySqlErrorDescription);
        }
}



}
if( PreviousFast>PreviousSlow && CurrentFast<CurrentSlow){
            if(previous_ao>0 && current_ao<0){
            
            
            OrderEntry(1);
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
            
            }



}


}
void OrderEntry(int direction)
{

if(direction == 0)
//
     if(OrdersTotal()==0)
     if(OrderSend(Symbol(),OP_BUY,LotSize,Ask,3,Ask-(StopLoss*pips),Ask+(TakeProfit*pips),NULL,MagicNumber,0,Green)==true)
      
     
     Print("Buying take place");

if(direction==1)
  if(OrdersTotal()==0) 
 
  if(OrderSend(Symbol(),OP_SELL,LotSize,Bid,3,Bid+(StopLoss*pips),Bid-(TakeProfit*pips),NULL,MagicNumber,0,Red)==true)
 
  
  
  Print("Selling Take place");

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

