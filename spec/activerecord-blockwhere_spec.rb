require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe ActiveRecord::Blockwhere do
  before(:each) do
    @alice        = Person.create!({:id => 1, :name => "Alice"  }, :without_protection => true)
    @bob          = Person.create!({:id => 2, :name => "Bob"    }, :without_protection => true)
    @carol        = Person.create!({:id => 3, :name => "Carol"  }, :without_protection => true)
    @entry1       = @alice.entries.create!({:id => 1}, :without_protection => true)
    @entry2       = @alice.entries.create!({:id => 2}, :without_protection => true)
    @entry3       = @bob.entries.create!({:id => 3}, :without_protection => true)
  end
    
  context 'simple where' do
    it { expect(Person.where{ id.eq(1)}.count ).to eq 1        }
    it { expect(Person.where{ id.eq(1)}.first ).to eq @alice   }
    it { expect(Person.where{ id.eq(1) | id.eq(2)}.map(&:name).sort ).to eq %w(Alice Bob      ) }
    it { expect(Person.where{ id.in([1, 3])      }.map(&:name).sort ).to eq %w(Alice     Carol) }
    it { expect(Person.where{ ! id.eq(1)         }.map(&:name).sort ).to eq %w(      Bob Carol) }
  end
  
  context 'where with association' do
    it { expect(Person.where{ entries.id.not_eq(0) }.map(&:name).sort.uniq ).to eq %w(Alice Bob      ) }
    it { expect(Person.where{ entries.id.eq(1)     }.map(&:name).sort      ).to eq %w(Alice          ) }
  end
  
  context 'where with context' do
    before(:each) do
      @context = Struct.new(:params).new({})
    end
    
    it do
      @context.params[:id] = 2
      expect(@context.instance_eval { Person.where{ id.eq(params[:id]) }.first } ).to eq @bob
    end
  end
  
  # https://github.com/techscore/activerecord-blockwhere/issues/2
  context 'Arel::Nodes::Limit and Arel::Nodes::Offset' do
    it { expect(!Arel::Nodes::Limit.new(10) ).to eq false      }
    it { expect(!Arel::Nodes::Offset.new(10)).to eq false      }
  end
  
end