awk '{ if (length(prev_depth) == 0) { \
         i=0; \
         print $1" (N/A - no previous measurement)" \
       } else { \
         if($1>prev_depth) { \
           i+=1; \
           print $1" (increased)" \
         } else { \
           print $1" (decreased)" \
         } \
       }\
       prev_depth=$1; \
     } END {print i}'
