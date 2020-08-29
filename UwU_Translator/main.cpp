#include <bits/stdc++.h>
using namespace std;
typedef long long ll;
#define mod 1000000007

int main(){
    freopen("input.txt", "r", stdin);
    freopen("out.txt", "w", stdout);
    string str;
    while(cin>>str){
        for(int i = 0; i < str.length(); i++){
            if(str[i] == 'r' || str[i] == 'l'){
                str[i] = 'w';
            }
            if(str[i] == 'R' || str[i] == 'L'){
                str[i] = 'W';
            }
        }
        cout<<str<<" ";
    }
    return 0;
}