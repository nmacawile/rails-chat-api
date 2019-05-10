require 'rails_helper'

RSpec.describe QueryUsers do
  describe '#call' do
    before { 
      create_list(:user, 5, first_name: 'Baz',
                            last_name: 'Biz')
      create_list(:user, 5, first_name: 'Foobar')
      create_list(:user, 5, last_name: 'Foobar')
    }
    subject { described_class.new(query) }
    
    context 'when query matches some users' do
      context 'with perfect matching letter cases' do
        let(:query) { 'Foobar' }
        
        it 'returns the query results' do
          expect(subject.call.count).to eq(10)
        end
      end
      
      context 'with partial match' do
        let(:query) { 'Foo' }
        
        it 'returns the query results' do
          expect(subject.call.count).to eq(10)
        end
      end
      
      context 'with full name match' do
        let(:query) { 'Baz Biz' }
        
        it 'returns the query results' do
          expect(subject.call.count).to eq(5)
        end
      end
      
      context 'with full name match, last name first' do
        let(:query) { 'Biz Baz' }
        
        it 'returns the query results' do
          expect(subject.call.count).to eq(5)
        end
      end
      
      context 'with full name match, having multiple spaces in between' do
        let(:query) { 'Baz           Biz' }
        
        it 'returns the query results' do
          expect(subject.call.count).to eq(5)
        end
      end
      
      context 'with unmatching letter cases' do
        let(:query) { 'fooBar' }
        
        it 'returns the query results' do
          expect(subject.call.count).to eq(10)
        end
      end
      
      context 'with null query' do
        let(:query) {}
        
        it 'returns all users' do
          expect(subject.call.count).to eq(15)
        end
      end
    end
    
    context 'when query doesn\'t find a match' do
      let(:query) { 'Houdini' }
      
      it 'returns an empty ActiveRecord object' do
        expect(subject.call).to be_empty
      end
    end
  end
end