class HighLine
  module Wrapper

    #
    # Wrap a sequence of _lines_ at _wrap_at_ characters per line.  Existing
    # newlines will not be affected by this process, but additional newlines
    # may be added.
    #
    def self.wrap(text, wrap_at)
      wrapped = [ ]
      text.each_line do |line|
        # take into account color escape sequences when wrapping
        wrap_at = highline.wrap_at + (line.length - highline.send(:actual_length, line))
        while line =~ /([^\n]{#{wrap_at + 1},})/
          search  = $1.dup
          replace = $1.dup
          if index = replace.rindex(" ", wrap_at)
            replace[index, 1] = "\n"
            replace.sub!(/\n[ \t]+/, "\n")
            line.sub!(search, replace)
          else
            line[$~.begin(1) + wrap_at, 0] = "\n"
          end
        end
        wrapped << line
      end
      return wrapped.join
    end
  end
end