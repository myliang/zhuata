require 'spec_helper'

describe ApplicationHelper do

  html = <<STR_END
<code language="c">
#include <stdlib.h>
#include <stdio.h>

#define N 10000

void main(int argc, char *argv){
  int i, j, a[N];
  for(i = 2; i < N; i++) a[i] = 1;
  for(i = 2; i < N; i++)
    if(a[i])
      for(j = i; i * j < N; j++) a[i * j] = 0;
  for(i = 2; i < N; i++)
    if(a[i]) printf("%4d", i);
  printf("\n");
}
</code>
STR_END
  class Test
    include CoderayHelper
  end

  it "parse language code" do
    puts Test.new.highlighter(html).to_s
  end
end
