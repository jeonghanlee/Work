#include <boost/variant.hpp> 
#include <boost/any.hpp> 
#include <vector> 
#include <string> 
#include <iostream> 

std::vector<boost::any> vector; 

struct output : 
  public boost::static_visitor<> 
{ 
  template <typename T> 
  void operator()(T &t) const 
  { 
    vector.push_back(t); 
  } 
}; 

int main() 
{ 
  boost::variant<double, char, std::string> v; 
  v = 3.14; 
  boost::apply_visitor(output(), v); 
  v = 'A'; 
  boost::apply_visitor(output(), v); 
  v = "Hello, world!"; 
  boost::apply_visitor(output(), v); 
} 