//
//  ViewController.m
//  PeekABoo
//
//  Created by Basel Farag on 8/16/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//
//I want to be able to view all the users as a grid of of photos
#import "ViewController.h"
#import "User.h"
#import "Photo.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property NSMutableArray *userArray;



@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.userArray = [NSMutableArray array];
    [self createUser];

}


-(void)createUser
{

    //load the array filled with objects into the myUser.photo NSSet?
    Photo *photo = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:self.managedObjectContext];
    photo.data = UIImagePNGRepresentation([UIImage imageNamed:@"Megaman1"]);
    User *myUser = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.managedObjectContext];
    //If you don't have the value inputted by the use ryou have to create them, in this case you have to create a name object.
    myUser.name = @"Mega Man";
    //Th
    [myUser addPhotosObject:photo];
    [self.userArray addObject:myUser];
    [self.managedObjectContext save:nil]; //the persistance store remains unaltered if you don't save it otherwise
    [self loadUser];


}

-(void)loadUser
{
    //Fetch the actual user
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    self.userArray = [[self.managedObjectContext executeFetchRequest:request error:nil]mutableCopy];
    [self.myCollectionView reloadData]; //everytime you add to the array you're going to need to reloadthe Data
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myCellID" forIndexPath:indexPath];
    User *user = [self.userArray objectAtIndex:indexPath.row];
    Photo *photo = [user.photos anyObject];
    NSData *data = photo.data;
    UIImage *image = [UIImage imageWithData:data];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [cell.contentView addSubview:imageView];

    return cell;
    //Remember whatever is on the left is what is being returned. So you're thinking should be, what do I need to do on the right ide to return what I need on the left side. Or more accurately. What is it that I want and how can I get there?
}



-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.userArray.count;
}

@end

