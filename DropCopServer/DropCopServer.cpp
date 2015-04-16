/* 
 * File:   main.cpp
 * Author: mo
 *
 * Created on April 10, 2015, 2:46 AM
 */

#include <Poco/Net/ServerSocket.h>
#include <Poco/Net/HTTPServer.h>
#include <Poco/Net/HTTPRequestHandler.h>
#include <Poco/Net/HTTPRequestHandlerFactory.h>
#include <Poco/Net/HTTPResponse.h>
#include <Poco/Net/HTTPServerRequest.h>
#include <Poco/Net/MessageHeader.h>
#include <Poco/Net/HTTPServerResponse.h>
#include <Poco/Net/HTMLForm.h>
#include <Poco/Util/ServerApplication.h>
#include <iostream>
#include <pqxx/pqxx>
#include <string>
#include <sstream>
#include <vector>

using namespace Poco::Net;
using namespace Poco::Util;
using namespace pqxx;
using namespace std;

class ExceptionHandler: public HTTPRequestHandler{
public:
    virtual void handleRequest( HTTPServerRequest &req, HTTPServerResponse &resp){
        // response headers
        resp.set("Access-Control-Allow-Origin", "*");
        resp.setStatus(HTTPResponse::HTTP_OK);
        resp.setContentType("text/json");
        // open stream to write response
        ostream& out = resp.send();
        out << "invalid";
        out.flush();
        
        cout << "invalid request" << endl;
    }
};



class LoginHandler : public HTTPRequestHandler
{
public:
  virtual void handleRequest(HTTPServerRequest &req, HTTPServerResponse &resp)
  {
      // response headers
      resp.set("Access-Control-Allow-Origin", "*");
      resp.setStatus(HTTPResponse::HTTP_OK);
      resp.setContentType("text/json");
    // open stream to write response
    ostream& out = resp.send();
    HTMLForm form(req);
    NameValueCollection::ConstIterator i = req.begin();
    string name;
    string value;
    
    /*
    // Request Checker
    while( i != (req.end()++)){
        name = i-> first;
        value = i->second;
        cout << name << " = " << value << endl << flush;
        ++i;
    }
    */
    
     //FORM CHECKER
    cout << "HTML FORM DATA " << endl;
    NameValueCollection::ConstIterator c = form.begin();
    string name2;
    string value2;
    while( c != (form.end()++)){
        name2 = c-> first;
        value2 = c->second;
        cout << name2 << " = " << value2 << endl << flush;
        ++c;
    }
    // open database connection
     try{
        connection C("dbname=DropCop user=mo password=cop hostaddr=127.0.0.1 port=5432");
        if (C.is_open()) {
           cout << "Opened database successfully: " << endl;
        } 
        else {
           cout << "Can't open database" << endl;
           out.flush();
           return;
        }
        /* Create SQL statement */
        string sql = "SELECT * from login where username = '" + form["username"]+"';";
        cout << sql << endl;
        /* Create a non-transactional object */
        nontransaction N(C);

        /* Execute SQL query */
        result R( N.exec(sql));
        
        // check R found
        if( R.end() - R.begin() == 1){
            // check if username and password match
            if(R.begin()[0].as<string>() == form["username"] && R.begin()[2].as<string>() == form["password"]){
                out << "{\"login\":\"true\"}";
                cout << "Login Passed" << endl;
                out.flush();
                C.disconnect();
                return;
            }
            // password did not match
            else if(R.begin()[0].as<string>() == form["username"] && R.begin()[2].as<string>() != form["password"]){
                out << "{\"login\":\"pfalse\"}";
                cout << "Password Failed" << endl;
                out.flush();
                C.disconnect();
                return;
            }
        }
        // login credentials not found
        else { 
            out << "{\"login\":\"false\"}";
            cout << "Login Failed" << endl;
            out.flush();
            C.disconnect();
            return;
        }
       out.flush();
       C.disconnect();
    }
    catch (const std::exception &e)
    {   
        //wrong something is not found -- wrong data request 
        cerr << e.what() << std::endl;
        out << "{\"login\":\"error\"}";
        cout << "LoginHandler Exception" << endl;
        out.flush();
        return;
    }
    out.flush();
    cout << "LoginHandler END" << endl;
    return;
  }

private:
};

class RegistrationHandler: public HTTPRequestHandler{
public:
    virtual void handleRequest(HTTPServerRequest &req, HTTPServerResponse &resp ){
        // response header
        resp.set("Access-Control-Allow-Origin", "*");
        resp.setStatus(HTTPResponse::HTTP_OK);
        resp.setContentType("text/json");
        // open stream to write response
        ostream& out = resp.send();
        HTMLForm form(req);
        
        try{
            connection C("dbname=DropCop user=mo password=cop hostaddr=127.0.0.1 port=5432");
            if (C.is_open()) {
                cout << "Opened database successfully: " << endl;
            } 
            else {
                cout << "Can't open database" << endl;
                out.flush();
                return;
            }
            
            /* Create SQL statement */
            string sql = "SELECT * from login where username = '" + form["username"]+"' or email = '" + form["email"] + "';";
            cout << sql << endl;
            /* Create a non-transactional object */
            nontransaction N(C);

            /* Execute SQL query */
            result R( N.exec(sql));
            N.commit(); // must release this process
            // check if already registered
            if( R.end() - R.begin() == 1){
                // check if username and password match
                out << "{\"registration\":\"false\"}";
                cout << "Registration Failed" << endl;
                out.flush();
                C.disconnect();
                return;
            }
            // register user
            else { 
               
                /* Create SQL statement */
                string rsql = "INSERT INTO login (username,password, email) VALUES ('" +form["username"]+ "','" +form["password"]+ "','" +form["email"]+ "');";
                cout << rsql << endl;
                /* Create a transactional object */
                work W(C);

                /* Execute SQL query */
                W.exec(rsql);
                W.commit();
                cout << "Registered User" << endl;
                out << "{\"registration\":\"true\"}";
                out.flush();
                C.disconnect();
                return;
            }
            C.disconnect();
            out.flush();
        }
         catch (const std::exception &e){   
            //wrong something is not found -- wrong data request 
            cerr << e.what() << std::endl;
            out << "{\"registration\":\"error\"}";
            cout << "Registration Exception" << endl;
            out.flush();
            return;
        }
        out.flush();
        cout << "RegistrationHandler END" << endl;
        return;
    }

private:    
};

// Request handler factory to correctly pick which handler to call depending on app
class MyRequestHandlerFactory : public HTTPRequestHandlerFactory
{
public:
  virtual HTTPRequestHandler* createRequestHandler(const HTTPServerRequest & request)
  {
      cout << request.getURI()<< endl;
      cout << "Request Handler Factory Started" << endl;
      // Beginning of URI signals which handler to call
      // SHOULD BE THE GET URI METHOD -- CHANGE THIS SECTION
      if ( request.getURI().substr(0,6) == "/login") {
          cout << "LoginHandler" << endl;
          return new LoginHandler();
      }
      else if( request.getURI().substr(0,9) == "/register"){
          cout << "RegistrationHandler" << endl;
          return new RegistrationHandler();
      }
      else {
          return new ExceptionHandler();
      }
      
  }
};

// Server app
class MyServerApp : public ServerApplication
{
protected:
  int main(const vector<string> &)
  {
    HTTPServer s(new MyRequestHandlerFactory, ServerSocket(9090), new HTTPServerParams);
    
    s.start();
    cout << endl << "Server started" << endl;

    waitForTerminationRequest();  // wait for CTRL-C or kill

    cout << endl << "Shutting down..." << endl;
    s.stop();

    return Application::EXIT_OK;
  }
};

int main(int argc, char** argv)
{
    // make and run server app
    MyServerApp app;
    return app.run(argc, argv);
}

