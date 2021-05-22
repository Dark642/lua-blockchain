function Sort(database_prop){
   return function(a,b){
      if(a[database_prop] > b[database_prop]){
          return 1;
      }else if(a[database_prop] < b[database_prop]){
          return -1;
      }
      return 0;
   }
}