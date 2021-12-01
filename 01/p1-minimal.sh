awk '{ if (length(prev_depth) == 0) { \
         i=0; \
       } else { \
         if($1>prev_depth) { \
           i+=1; \
         } \
       }\
       prev_depth=$1; \
     } END {print i}'
