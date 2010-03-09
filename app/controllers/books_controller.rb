class BooksController < ApplicationController
  # GET /books
  # GET /books.xml
  def index
    @books = Book.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @books }
    end
  end

  # GET /books/1
  # GET /books/1.xml
  def show
    @book = Book.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @book }
    end
  end

  # GET /books/new
  # GET /books/new.xml
  def new
    @book = Book.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @book }
    end
  end

  # GET /books/1/edit
  def edit
    @book = Book.find(params[:id])
  end

  # POST /books
  # POST /books.xml
  def create
    @book = Book.new(params[:book])

    respond_to do |format|
      if @book.save
        format.html { redirect_to(@book, :notice => 'Book was successfully created.') }
        format.xml  { render :xml => @book, :status => :created, :location => @book }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @book.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /books/1
  # PUT /books/1.xml
  def update
    @book = Book.find(params[:id])

    respond_to do |format|
      if @book.update_attributes(params[:book])
        format.html { redirect_to(@book, :notice => 'Book was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @book.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.xml
  def destroy
    @book = Book.find(params[:id])
    @book.destroy

    respond_to do |format|
      format.html { redirect_to(books_url) }
      format.xml  { head :ok }
    end
  end


  # TODO: move this into /lib and add support for ISBNDB which has better results, but no images
  require 'amazon/aws'
  require 'amazon/aws/search'
  def lookup
    il = Amazon::AWS::ItemLookup.new( 'ASIN', { 'ItemId' => params[:isbn] } )
    rg = Amazon::AWS::ResponseGroup.new( 'Medium' )
    req = Amazon::AWS::Search::Request.new
    resp = req.search(il, rg)

  
    getattr = [:title, :author, :publisher, :edition]

    item = resp.item_lookup_response[0].items[0].item
    attr = item.item_attributes[0]

    # HACK! just grab a review as summary. TODO: something smarter.
    review = item.editorial_reviews[0].editorial_review[0].content[0].to_s rescue nil

    @book = {:summary => review}
    getattr.each do |a|
      @book[a] = attr.send(a)[0].to_str rescue nil
    end

    respond_to do |format|
      format.json { render :json => @book }
      format.xml { render :xml => @book }
    end
  end
end
