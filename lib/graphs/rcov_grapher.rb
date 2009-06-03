require 'gruff'
module MetricFu
  
  class RcovGrapher
    
    attr_accessor :rcov_percent, :labels
    
    def initialize
      self.rcov_percent = []
      self.labels = {}
    end
    
    def get_metrics(metrics, date)
      self.rcov_percent.push(metrics[:rcov][:global_percent_run])
      self.labels.update( { self.labels.size => date })
    end
    
    def graph!
      g = Gruff::Line.new(MetricFu.graph_size)
      g.title = "Rcov: code coverage"
      g.theme = MetricFu.graph_theme
      g.font = MetricFu.graph_font
      g.data('rcov', self.rcov_percent)
      g.labels = self.labels
      g.write(File.join(MetricFu.output_directory, 'rcov.png'))
    end
    
  end
  
end
