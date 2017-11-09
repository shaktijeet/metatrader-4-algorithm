/*

This is an indicator i am going to develop for binary trading only 
peoples are using several concept to trade but my concept quite easier to other one 

i am using to indicator for trade first is stochastic with cci indicator 


*/


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
extern int TakeProfit = 50;
extern int StopLoss = 25;


extern bool UseMoveToBreakeven= true;
extern int WhenToMoveBe = 100;
extern int PipsToLockIn = 5;

extern int FastMA=5;
extern int FastMaShift= 0;
 extern int FastMaMethod = 0;
 extern int FastMaAppliedTo = 0;
extern int SlowMA=21;
extern int SlowMaShift= 0;
 extern int SlowMaMethod = 0;
 extern int SlowMaAppliedTo = 0;
extern double LotSize = 0.01;
extern int MagicNumber = 1234;
extern int add_time = 4;
double pips;
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
//now i am ging to write stochastic concept to trade take place

double k_line = iStochastic(NULL,0,5,3,3,0,0,MODE_MAIN,1);
double d_line = iStochastic(NULL,0,5,3,3,0,0,MODE_SIGNAL,1);

double previous_k_line = iStochastic(NULL,0,5,3,3,0,0,MODE_MAIN,2);
double previous_d_line = iStochastic(NULL,0,5,3,3,0,0,MODE_SIGNAL,2);
double current_cci = iCCI(NULL, 0,14,PRICE_CLOSE,1);
double previous_cci = iCCI(NULL,0,14,PRICE_CLOSE,2);

if(previous_k_line > 74){
  if(previous_k_line> previous_d_line && k_line < d_line)
 {
 
 //this block is used to  check cci conecpt  here 
 if(previous_cci>100 && current_cci <100){
//here is the code to take trade 

OrderEntry(1);//yaha par cci ke hisaaf se <0> hona chaiye
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

if(previous_d_line<14){

if(previous_k_line < previous_d_line && k_line > d_line){

//here we write the code cci indicator cross

if(previous_cci< -100 && current_cci > -100){

//here is the code to take trade
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


}

/*
double PreviousFast = iMA(NULL,0,FastMA,FastMaShift,FastMaMethod, FastMaAppliedTo,2);

double CurrentFast = iMA(NULL,0,FastMA,FastMaShift,FastMaMethod, FastMaAppliedTo,1);



double PreviousSlow = iMA(NULL,0,SlowMA,SlowMaShift,SlowMaMethod, SlowMaAppliedTo,2);

double CurrentSlow =     iMA(NULL,0,SlowMA,SlowMaShift,SlowMaMethod, SlowMaAppliedTo,1);

if( PreviousFast<PreviousSlow && CurrentFast>CurrentSlow)OrderEntry(0); //zero for buyinf action 
if( PreviousFast>PreviousSlow && CurrentFast<CurrentSlow)OrderEntry(1); // one for selling action

*/
}



void OrderEntry(int direction)
{

if(direction == 0)
     if(OrdersTotal()==0)
     if(OrderSend(Symbol(),OP_BUY,LotSize,Ask,3,Ask-(StopLoss*pips),Ask+(TakeProfit*pips),NULL,MagicNumber,0,Green)==true)
     Print("Buying take Place");

if(direction==1)
  if(OrdersTotal()==0) 
  if(OrderSend(Symbol(),OP_SELL,LotSize,Bid,3,Bid+(StopLoss*pips),Bid-(TakeProfit*pips),NULL,MagicNumber,0,Red)==true)
  Print("Selling take Place");
}  

/*

void CheckForSignal(){

static datetime candletime  =0 ;
if(candletime != Time[0]){
 //Did it make up  arrow on candle 1?
 
double upArrow = iCustom(NULL,0,"Profit Sunrise",1,0);
if(upArrow != EMPTY_VALUE)
OrderEntry(0);
//now make executiobn of trade ...by you 


 //Did it make up  arrow on candle 1?

double downArrow = iCustom(NULL,0,"Profit Sunrise",3,0);
if(downArrow != EMPTY_VALUE)
// //now make executiobn of trade ...by you order to trade
OrderEntry(1);
candletime = Time[0];

}





}






*/


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
