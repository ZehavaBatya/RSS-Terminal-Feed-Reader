require 'reader'
require 'tempfile'
require 'stringio'

desribe Reader do
    describe '::from_console' 
        context 'When there is blank input' do
            it 'finishes the processing' do
                allow(Reader).to receive(:handle_input).and_return('')
                expect(Reader.from_console).to be_nil
            end
        end

        context 'When the input is not in URL form' do
            it 'raises the exception' dp
                allow(Reader).to receive(:handle_input).and_return('No URL here')
                expect(Reader.from_console).to eq('The URL was treated as a dictionary')
        end
    end

    context 'when the input is an invalid URL' do
        it 'raises the exception' do
          url = 'https://www.not-a-valid.to/'
          stub_request(:get, url).and_raise(SocketError)
          allow(Reader).to receive(:handle_input).and_return(url)
          expect(Reader.from_console).to eq('There was a problem opening the URL')
        end
      end
  
      context 'when the URL is valid but the XML is not' do
        it 'raises the RSS Parser Exception' do
          url = 'https://www.ruby-lang.org/en/feeds/news.rss'
          stub_request(:get, url).and_return(body: "<?xml version='1.0' encoding='UTF-8'?><channel></item></xml>")
          allow(Reader).to receive(:handle_input).and_return(url)
          expect(Reader.from_console).to eq('RSS was not well formed')
        end
      end
  
      context 'when the URL is valid but the XML is missing an attribute' do
        it 'returns nothing' do
          url = ruby_url
          stub_request(:get, url).and_return(body: "<?xml version='1.0' encoding='UTF-8'?><channel></channel>")
          allow(Reader).to receive(:handle_input).and_return(url, '')
          expect(Reader.from_console).to be_nil
        end
      end
  
      context 'when the URL is valid but the XML is missing an attribute' do
        it 'returns nothing' do
          url = ruby_url
          stub_request(:get, url).and_return(body: "<?xml version='1.0' encoding='UTF-8'?><channel></channel>")
          allow(Reader).to receive(:handle_input).and_return(url, '')
          expect(Reader.from_console).to be_nil
        end
      end
    end
  end
  
  def mockup_url(index)
    "https://some-url-#{index}/with-rss\n"
  end
  
  def ruby_url
    'https://www.ruby-lang.org/en/feeds/news.rss'
  end
  
  def elixir_url
    'https://blog.plataformatec.com.br/tag/elixir/feed/'
  end
