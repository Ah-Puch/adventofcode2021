awk '{
      if (length(d1) == 0) { \
        if (length(d0) == 0) { \
          d0=$1; \
        } else {
          d1=d0;
          d0=$1;
          i=0;
        }
      } else { \
        d2=d1;
        d1=d0;
        d0=$1;
        depth=d2+d1+d0;
        if (length(prev_depth) == 0) { \
          i=0; \
          print depth" (N/A - no previous measurement)" \
        } else { \
          if(depth>prev_depth) { \
            i+=1; \
            print depth" (increased)" \
          } else { \
            if(depth<prev_depth) { \
              print depth" (decreased)" \
            } else { \
              print depth" (no change)" \
            } \
          } \
        } \
        prev_depth=depth; \
      } \
     } END {print i}'
