awk '{
      if (length(d1) == 0) { \
        if (length(d0) == 0) { \
          d0=$1; \
        } else {
          d1=d0;
          d0=$1;
          i=0; \
        }
      } else { \
        d2=d1;
        d1=d0;
        d0=$1;
        depth=d2+d1+d0;
        if (length(prev_depth) != 0) { \
          if(depth>prev_depth) { \
            i+=1; \
          } \
        } \
        prev_depth=depth; \
      } \
     } END {print i}'
