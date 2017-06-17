int fun(int *a){
    int b = 3;
    return *a + b;
}
int main(){
    int a = 5;
    fun(&a);
}
// int fun(int* a, int* b) {
//     return *a + *b;
// }

